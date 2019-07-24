//
//  FriendsController.swift
//  vkClient
//
//  Created by Ruslan Guseynov on 02/07/2019.
//  Copyright © 2019 Ruslan Guseynov. All rights reserved.
//

import UIKit

class FriendsController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var alphabetNavigationControl: AlphabetNavigationControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    fileprivate var friends = User.getFriends()
    fileprivate var friendsGrouped: [Character: [User]] = [:]
    fileprivate var characters = [Character]()
    fileprivate var friendsFiltered = [User]()
    fileprivate var isSearchActive = false
    
    override func viewDidLoad() {
        friends.sort { $0.firstName < $1.firstName }
        groupFriends()
        
        alphabetNavigationControl.setupAlphabetButtons(for: friends)
        alphabetNavigationControl.tableView = tableView
    }
    
    private func groupFriends() {
        for friend in friends {
            guard let firstLetterRaw = friend.firstName.first else { continue }
            let firstLetter = Character(firstLetterRaw.uppercased())
            
            if friendsGrouped.keys.contains(firstLetter) {
                friendsGrouped[firstLetter]?.append(friend)
            } else {
                friendsGrouped[firstLetter] = [friend]
            }
        }
        characters = friendsGrouped.keys.sorted()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? FriendsPhotosController,
            let indexPath = tableView.indexPathForSelectedRow else { return }
        guard let friendsForThisSection = friendsGrouped[characters[indexPath.section]] else { return }
        
        if isSearchActive {
            guard let friendCell = tableView.cellForRow(at: indexPath) as? FriendCell else { return }
            guard let friendCellText = friendCell.nameLabel.text else { return }
            let firstName = friendCellText.components(separatedBy: " ")[0]
            let lastName = friendCellText.components(separatedBy: " ")[1]
            
            //doesn't work correctly if there are two or more people with the same names
            #warning("change to comparison by id")
            for friend in friends {
                if friend.firstName == firstName, friend.lastName == lastName {
                    destinationVC.photosNames = friend.photos
                    break;
                }
            }
        } else {
            destinationVC.photosNames = friendsForThisSection[indexPath.row].photos
        }
    }
}

extension FriendsController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return isSearchActive ? 1 : friendsGrouped.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var friend: User
        if isSearchActive {
            guard friendsFiltered.count > 0 else {
                let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
                cell.textLabel?.text = "No results" //doesn't show anything
                #warning("show `no results` label here")
                return cell
            }
            friend = friendsFiltered[indexPath.row]
        } else {
            guard let friendsForThisSection = friendsGrouped[characters[indexPath.section]] else { return FriendCell() }
            friend = friendsForThisSection[indexPath.row]
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell") as! FriendCell
        cell.nameLabel.text = "\(friend.firstName) \(friend.lastName)"
        cell.avatarView.imageView.image = UIImage(named: friend.avatarImageName)
        cell.separatorInset = UIEdgeInsets(top: 0, left: cell.nameLabel.frame.minX, bottom: 0, right: 0)

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchActive
            ? friendsFiltered.count
            : friendsGrouped[characters[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UILabel()
        header.text = "    \(characters[section])"
        header.backgroundColor = #colorLiteral(red: 0.9214878678, green: 0.9216204286, blue: 0.9214589, alpha: 1).withAlphaComponent(0.2)
        return header
    }
    
    //Hide section header when showing search results
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return isSearchActive ? 0 : tableView.sectionHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension FriendsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
}

extension FriendsController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearchActive = searchText == "" ? false : true
        if isSearchActive {
            friendsFiltered.removeAll()
            for friend in friends {
                if friend.firstName.localizedCaseInsensitiveContains(searchText)
                    || friend.lastName.localizedCaseInsensitiveContains(searchText) {
                    friendsFiltered.append(friend)
                }
            }
        }
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearchActive = false
        searchBar.text = nil
        searchBar.setShowsCancelButton(false, animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        tableView.reloadData()
    }
}

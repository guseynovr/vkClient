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
    
    //TODO: delete demo, load actual data
    fileprivate var friends = User.getFriends()
    fileprivate var friendsGrouped: [Character: [User]] = [:]
    fileprivate var characters = [Character]()
    
    override func viewDidLoad() {
        friends.sort { $0.firstName < $1.firstName }
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
        
        alphabetNavigationControl.setupAlphabetButtons(for: friends)
        alphabetNavigationControl.tableView = tableView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? FriendsPhotosController,
            let indexPath = tableView.indexPathForSelectedRow else { return }

        guard let friendsForThisSection = friendsGrouped[characters[indexPath.section]] else { return }
        destinationVC.photosNames = friendsForThisSection[indexPath.row].photos
    }
}

extension FriendsController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return friendsGrouped.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell") as! FriendCell
        
        guard let friendsForThisSection = friendsGrouped[characters[indexPath.section]] else { return FriendCell() }
        let friend = friendsForThisSection[indexPath.row]
        cell.nameLabel.text = "\(friend.firstName) \(friend.lastName)"
        cell.avatarView.imageView.image = UIImage(named: friend.avatarImageName)
        cell.separatorInset = UIEdgeInsets(top: 0, left: cell.nameLabel.frame.minX, bottom: 0, right: 0)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsGrouped[characters[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UILabel()
        header.text = "    \(characters[section])"
        header.backgroundColor = #colorLiteral(red: 0.9214878678, green: 0.9216204286, blue: 0.9214589, alpha: 1)
        return header
    }
    
}

extension FriendsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

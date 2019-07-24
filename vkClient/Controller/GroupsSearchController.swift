//
//  GroupsSearchController.swift
//  vkClient
//
//  Created by Ruslan Guseynov on 02/07/2019.
//  Copyright © 2019 Ruslan Guseynov. All rights reserved.
//

import UIKit

class GroupsSearchController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var groups: [Group] = [
        Group(name: "Команда Вконтакте", avatarImageName: "vkTeam"),
        Group(name: "Открытый космос", avatarImageName: "openSpace"),
        Group(name: "вДудь", avatarImageName: "vdud"),
        Group(name: "MTV", avatarImageName: "mtv"),
        Group(name: "РБК", avatarImageName: "rbk"),
        Group(name: "Forbes", avatarImageName: "forbes")
    ]
    fileprivate var groupsFiltered = [Group]()
    fileprivate var isSearchActive = false
    
    //MARK: TableViewDataSource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchActive ? groupsFiltered.count : groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell") as! GroupCell
        
        let group = isSearchActive ? groupsFiltered[indexPath.row] : groups[indexPath.row]
        cell.nameLabel.text = group.name
        cell.avatarView.imageView.image = UIImage(named: group.avatarImageName)
        cell.separatorInset = UIEdgeInsets(top: 0, left: cell.nameLabel.frame.minX, bottom: 0, right: 0)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    //MARK: TableViewDelegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
}

extension GroupsSearchController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearchActive = searchText == "" ? false : true
        if isSearchActive {
            groupsFiltered.removeAll()
            for group in groups {
                if group.name.localizedCaseInsensitiveContains(searchText) {
                    groupsFiltered.append(group)
                }
            }
        }
        tableView.reloadData()
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        return true
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

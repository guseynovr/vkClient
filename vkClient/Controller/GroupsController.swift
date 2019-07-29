//
//  GroupsController.swift
//  vkClient
//
//  Created by Ruslan Guseynov on 02/07/2019.
//  Copyright © 2019 Ruslan Guseynov. All rights reserved.
//

import UIKit

class GroupsController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var userGroups: [Group] = []
    fileprivate var groupsFiltered = [Group]()
    fileprivate var isSearchActive = false
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        let sourceVC = segue.source as! GroupsSearchController
        
        guard let indexPath = sourceVC.tableView.indexPathForSelectedRow else { return }
        
        guard !userGroups.contains(where: {
            $0.name == sourceVC.groups[indexPath.row].name
        }) else { return }
        
        userGroups.append(sourceVC.groups[indexPath.row])
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            userGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    
    //MARK: TableViewDataSource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchActive ? groupsFiltered.count : userGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell") as! GroupCell
        
        let group = isSearchActive ? groupsFiltered[indexPath.row] : userGroups[indexPath.row]
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

extension GroupsController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearchActive = searchText == "" ? false : true
        if isSearchActive {
            groupsFiltered.removeAll()
            for group in userGroups {
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

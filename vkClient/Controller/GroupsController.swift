//
//  GroupsController.swift
//  vkClient
//
//  Created by Ruslan Guseynov on 02/07/2019.
//  Copyright © 2019 Ruslan Guseynov. All rights reserved.
//

import UIKit

class GroupsController: UITableViewController {
    
    var userGroups: [Group] = []
    
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
        return userGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell") as! GroupCell
        
        cell.nameLabel.text = userGroups[indexPath.row].name
        cell.avatarView.imageView.image = UIImage(named: userGroups[indexPath.row].avatarImageName)
        cell.separatorInset = UIEdgeInsets(top: 0, left: cell.nameLabel.frame.minX, bottom: 0, right: 0)

        
        return cell
    }
    
    //MARK: TableViewDelegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

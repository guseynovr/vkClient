//
//  GroupsSearchController.swift
//  vkClient
//
//  Created by Ruslan Guseynov on 02/07/2019.
//  Copyright © 2019 Ruslan Guseynov. All rights reserved.
//

import UIKit

class GroupsSearchController: UITableViewController {
    
    var groups: [Group] = [
        Group(name: "Команда Вконтакте", avatarImageName: "vkTeam"),
        Group(name: "Открытый космос", avatarImageName: "openSpace"),
        Group(name: "вДудь", avatarImageName: "vdud"),
        Group(name: "MTV", avatarImageName: "mtv"),
        Group(name: "РБК", avatarImageName: "rbk"),
        Group(name: "Forbes", avatarImageName: "forbes")
    ]
    
    //MARK: TableViewDataSource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell") as! GroupCell
        
        cell.nameLabel.text = groups[indexPath.row].name
        cell.avatarImage.image = UIImage(named: groups[indexPath.row].avatarImageName)
        
        return cell
    }
    
    //MARK: TableViewDelegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

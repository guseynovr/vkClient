//
//  FriendsController.swift
//  vkClient
//
//  Created by Ruslan Guseynov on 02/07/2019.
//  Copyright © 2019 Ruslan Guseynov. All rights reserved.
//

import UIKit

class FriendsController: UITableViewController {
    
    
    //TODO: delete demo, load actual data
    fileprivate let friends = [
        User(id: 1, firstName: "Bruce", lastName: "Wayne", avatarImageName: "batman-avatar"),
        User(id: 2, firstName: "Jason", lastName: "Todd", avatarImageName: "robin-avatar"),
        User(id: 3, firstName: "Harley", lastName: "Quinn", avatarImageName: "harley-avatar"),
        User(id: 4, firstName: "Jack", lastName: "Napier", avatarImageName: "joker-avatar"),
        User(id: 5, firstName: "Lucy", lastName: "Wyldstyle", avatarImageName: "lucy-avatar")
    ]
    
    fileprivate let photos = [
        ["batman1", "batman2", "batman3", "batman4",
         "batman5", "batman6", "batman7", "batman8"],
        
        ["robin1", "robin2", "robin3", "robin4"],
        
        ["harley1", "harley2", "harley3"],
        
        ["joker1", "joker2", "joker3", "joker4",
         "joker5", "joker6"],
        
        ["lucy1", "lucy2", "lucy3", "lucy4"]
    ]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let destinationVC = segue.destination as? FriendsPhotosController,
            let indexPath = tableView.indexPathForSelectedRow else { return }

        destinationVC.photosNames = photos[indexPath.row]
    }
    
    
     // MARK: TableViewDataSource methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell") as! FriendCell
        
        let friend = friends[indexPath.row]
        cell.nameLabel.text = "\(friend.firstName) \(friend.lastName)"
        cell.avatarImage.image = UIImage(named: friend.avatarImageName)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    // MARK: TableViewDelegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

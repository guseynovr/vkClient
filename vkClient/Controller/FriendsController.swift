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
    
    override func viewDidLoad() {
        friends.sort { $0.firstName < $1.firstName }
        
        alphabetNavigationControl.setupAlphabetButtons(for: friends)
        alphabetNavigationControl.tableView = tableView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? FriendsPhotosController,
            let indexPath = tableView.indexPathForSelectedRow else { return }
        
        
        destinationVC.photosNames = friends[indexPath.row].photos
    }
}

extension FriendsController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell") as! FriendCell
        
        let friend = friends[indexPath.row]
        cell.nameLabel.text = "\(friend.firstName) \(friend.lastName)"
        cell.avatarView.imageView.image = UIImage(named: friend.avatarImageName)
        cell.separatorInset = UIEdgeInsets(top: 0, left: cell.nameLabel.frame.minX, bottom: 0, right: 0)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
}

extension FriendsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

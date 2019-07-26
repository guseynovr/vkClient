//
//  NewsController.swift
//  vkClient
//
//  Created by Ruslan Guseynov on 25/07/2019.
//  Copyright © 2019 Ruslan Guseynov. All rights reserved.
//

import UIKit

class NewsController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var feed = Post.getPosts()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "newsCell")
        
    }
}

extension NewsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell") as! NewsCell
        
        let post = feed[indexPath.row]
        if let photoName = post.photos?[0] {
            cell.avatarView.imageView.image = UIImage(named: photoName)
        }
        cell.authorNameLabel.text = { return "123" }()
        cell.likeButton.likeCount = post.likes
        
        return cell
    }
}

extension NewsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

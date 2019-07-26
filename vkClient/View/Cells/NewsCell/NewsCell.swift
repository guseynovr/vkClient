//
//  NewsCell.swift
//  vkClient
//
//  Created by Ruslan Guseynov on 24/07/2019.
//  Copyright © 2019 Ruslan Guseynov. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    
    
    @IBOutlet weak var avatarView: AvatarView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var likeButton: LikeButton!
    @IBOutlet weak var commentButton: CommentButton!
    @IBOutlet weak var shareButton: ShareButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

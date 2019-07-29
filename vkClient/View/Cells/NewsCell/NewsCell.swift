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
    @IBOutlet weak var likeButton: LikeControl!
    @IBOutlet weak var commentButton: CommentButton!
    @IBOutlet weak var shareButton: ShareButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setFields(avatarViewImage: UIImage, authorName: String, photos: [String]?,likeCount: Int, commentCount: Int, shareCount: Int) {
        
        avatarView.imageView.image = avatarViewImage
        authorNameLabel.text = authorName
        
        likeButton.likeCount = likeCount
        commentButton.setTitle("\(likeCount)", for: .normal)
        shareButton.setTitle("\(shareCount)"
            , for: .normal)
    }
    
}

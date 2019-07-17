//
//  AvatarView.swift
//  vkClient
//
//  Created by Ruslan Guseynov on 13/07/2019.
//  Copyright © 2019 Ruslan Guseynov. All rights reserved.
//

import UIKit

class AvatarView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBInspectable var shadowColor: UIColor = UIColor.black
    @IBInspectable var shadowRadius: CGFloat = 1
    @IBInspectable var shadowOpacity: Float = 1

    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.layer.masksToBounds = true
        
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = .zero
    }
    
    override func layoutSubviews() {
        imageView.layer.cornerRadius = bounds.width / 2
        layer.cornerRadius = imageView.bounds.width / 2
    }
}

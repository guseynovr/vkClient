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
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    
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
        
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateTap)))
    }
    
    override func layoutSubviews() {
        imageView.layer.cornerRadius = bounds.width / 2
        layer.cornerRadius = bounds.width / 2
    }
    
    @objc func animateTap(_ sender: UITapGestureRecognizer) {
        self.superview?.layoutIfNeeded()
        UIView.animate(withDuration: 0.1, animations: {
            self.topConstraint.constant = 8
            self.bottomConstraint.constant = 8
            self.leadingConstraint.constant = 13
            self.trailingConstraint.constant = 13
            self.layoutIfNeeded()
        }, completion: { (Bool) in
            UIView.animate(withDuration: 0.075,
                           delay: 0,
                           usingSpringWithDamping: 0.08,
                           initialSpringVelocity: 5,
                           options: .curveEaseOut,
                           animations: {
                            self.topConstraint.constant = 5
                            self.bottomConstraint.constant = 5
                            self.leadingConstraint.constant = 10
                            self.trailingConstraint.constant = 10
                            self.layoutIfNeeded()
            }, completion: nil)
        })
    }
}

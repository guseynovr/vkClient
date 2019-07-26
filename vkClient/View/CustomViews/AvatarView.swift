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
        print("avatar tapped")
        

        
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
        
        //Longer animation
//        self.superview?.layoutIfNeeded()
//        UIView.animate(withDuration: 0.4, animations: {
//            self.topConstraint.constant = 8
//            self.bottomConstraint.constant = 8
//            self.leadingConstraint.constant = 13
//            self.trailingConstraint.constant = 13
//
//            self.layoutIfNeeded()
//        }, completion: { (Bool) in
//            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 5, options: .curveEaseOut, animations: {
//                self.topConstraint.constant = 5
//                self.bottomConstraint.constant = 5
//                self.leadingConstraint.constant = 10
//                self.trailingConstraint.constant = 10
//                self.layoutIfNeeded()
//            }, completion: nil)
//        })
        
//        self.superview?.layoutIfNeeded()
//        UIView.animate(withDuration: 1) {
//            self.topConstraint.constant = 8
//            self.bottomConstraint.constant = 8
//            self.leadingConstraint.constant = 13
//            self.trailingConstraint.constant = 13
//            self.layoutIfNeeded()
//        }
        
//        let animation = CABasicAnimation(keyPath: "bounds")
//        animation.fromValue = imageView.bounds
//        animation.toValue = CGRect(
//            x: imageView.bounds.origin.x + 100,
//            y: imageView.bounds.origin.y,
//            width: imageView.bounds.size.width * 0.8,
//            height: imageView.bounds.size.height * 0.8)
//        animation.duration = 1
//        imageView.layer.add(animation, forKey: nil)
//
//        let animation2 = CABasicAnimation(keyPath: "bounds")
//        animation2.fromValue = bounds
//        animation2.toValue = CGRect(
//            x: bounds.origin.x,
//            y: bounds.origin.y,
//            width: bounds.size.width * 0.8,
//            height: bounds.size.height * 0.8)
//        animation2.duration = 1
//        layer.add(animation2, forKey: nil)
        
//        UIView.animate(withDuration: 1) {
//            self.imageView.bounds = CGRect(
//                x: self.imageView.bounds.origin.x,
//                y: self.imageView.bounds.origin.y,
//                width: self.imageView.bounds.size.width * 0.8,
//                height: self.imageView.bounds.size.height)
//
//            self.bounds = CGRect(
//                x: self.bounds.origin.x,
//                y: self.bounds.origin.y,
//                width: self.bounds.size.width * 0.8,
//                height: self.bounds.size.height * 0.8)
//        }
        
//        UIView.animate(withDuration: 1) {
//            self.bounds = CGRect(
//                x: self.bounds.origin.x,
//                y: self.bounds.origin.y,
//                width: self.bounds.size.width * 0.8,
//                height: self.bounds.size.height * 0.8)
//        }
        
        
//        UIView.animate(withDuration: 2) {
//            self.imageView.bounds = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.frame.size.width * 2, height: self.frame.size.height * 2)
////            self.imageView.layer.cornerRadius = self.bounds.width / 2
//            self.imageView.frame.origin.x = self.imageView.frame.origin.x + 50
//        }
//        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveLinear, animations: {
//            self.imageView.frame.origin.x = self.imageView.frame.origin.x + 50
//        })
    }
}

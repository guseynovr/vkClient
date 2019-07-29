//
//  LikeButton.swift
//  vkClient
//
//  Created by Ruslan Guseynov on 15/07/2019.
//  Copyright © 2019 Ruslan Guseynov. All rights reserved.
//

import UIKit

class LikeControl: UIStackView {
    
    private var imageView: UIImageView!
    private var countLabel: UILabel!
    
    private var isLiked = false { didSet { likeCount += isLiked ? 1 : -1 } }
    var likeCount = 999 { didSet { updateAppearance() } }
    
    override init(frame: CGRect) { super.init(frame: frame); setupControl() }
    
    required init(coder: NSCoder) { super.init(coder: coder); setupControl() }
    
    func setupControl() {
        axis = .horizontal
        alignment = .center
        distribution = .fillEqually
        
        heightAnchor.constraint(equalToConstant: 28).isActive = true
        
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        countLabel = UILabel()
        countLabel.font = .systemFont(ofSize: 15)

        updateAppearance()
        
        addArrangedSubview(imageView)
        addArrangedSubview(countLabel)
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onLikeTapped)))
    }
    
    @objc func onLikeTapped() {
        isLiked.toggle()
    }
    
    func updateAppearance() {
        self.imageView.image = UIImage(named: self.isLiked ? "heart-filled" : "heart-empty")

        UIView.transition(with: countLabel, duration: 0.2, options: .transitionFlipFromTop, animations: {
            self.countLabel.text = self.countShortened()
            self.countLabel.textColor = self.isLiked ? .red : .black
        }, completion: nil)
    }
    
    func countShortened() -> String {
        guard likeCount >= 1000 else { return "\(likeCount)" }
        
        #warning("implement shortening")
        return "\(likeCount)"
    }
}

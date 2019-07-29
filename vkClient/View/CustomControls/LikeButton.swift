//
//  LikeButton.swift
//  vkClient
//
//  Created by Ruslan Guseynov on 15/07/2019.
//  Copyright © 2019 Ruslan Guseynov. All rights reserved.
//

import UIKit

class LikeButton: UIButton {
    
    var isLiked = false { didSet { updateCount(); updateAppearance(); } }
    
    var likeCount: Int = 0 ;#warning("3 digit numbers don't fit")
    
    
    override init(frame: CGRect) { super.init(frame: frame); setupButton() }
    
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder); setupButton() }
    
    func setupButton() {
        updateAppearance()
        
        backgroundColor = UIColor.white.withAlphaComponent(0.4)
        layer.cornerRadius = 12
        layer.masksToBounds = true
        
        addTarget(self, action: #selector(onButtonTapped), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let imageView = imageView, let titleLabel = titleLabel else { return }
        
        imageView.bounds.size = CGSize(width: 30, height: 30)
        titleLabel.bounds.size = CGSize(width: 30, height: 30)
        titleLabel.textAlignment = .center
        
        contentEdgeInsets = UIEdgeInsets(top: -8, left: -8, bottom: -8, right: 4)
    }
    
    private func updateAppearance() {
        setImage(UIImage(named: isLiked ? "liked" : "not-liked"), for: .normal)
        
        setTitle("\(likeCount)", for: .normal)
        setTitleColor(isLiked ? .red : .black, for: .normal)
    }
    
    private func updateCount() { likeCount += isLiked ? 1 : -1 }
    
    @objc func onButtonTapped() {
        isLiked.toggle()
    }
    
}

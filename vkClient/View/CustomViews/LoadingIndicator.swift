//
//  loadingIndicator.swift
//  vkClient
//
//  Created by Ruslan Guseynov on 26/07/2019.
//  Copyright © 2019 Ruslan Guseynov. All rights reserved.
//

import UIKit

class LoadingIndicator: UIStackView {

    var circles = [UIView(), UIView(), UIView()]
    
    var width: CGFloat!// = { frame.width / 3 }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupIndicator()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupIndicator()
    }
    
    func setupIndicator() {
        setupStackViewProperties()
        setupCircles()
        setupAnimation()
    }
    
    fileprivate func setupStackViewProperties() {
        axis = .horizontal
        alignment = .center
        distribution = .equalCentering
        spacing = frame.width / 15
    }
    
    fileprivate func setupCircles() {
        width = (frame.width - spacing * (CGFloat(circles.count) - 1)) / 3
        circles.forEach { (circle) in
            circle.backgroundColor = .white
            circle.widthAnchor.constraint(equalToConstant: width).isActive = true
            circle.heightAnchor.constraint(equalToConstant: width).isActive = true
            
            circle.layer.cornerRadius = width / 2
            circle.layer.masksToBounds = true
            
            addArrangedSubview(circle)
        }
    }
    
    fileprivate func setupAnimation() {
        for i in 0..<circles.count {
            UIView.animate(withDuration: 0.6, delay: TimeInterval(0.2 * (Double(i) + 1)), options: [.repeat, .autoreverse], animations: {
                self.circles[i].alpha = 0.3
            })
        }
    }
}

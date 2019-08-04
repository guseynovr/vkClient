//
//  RotationTransitioningAnimator.swift
//  vkClient
//
//  Created by Ruslan Guseynov on 04/08/2019.
//  Copyright © 2019 Ruslan Guseynov. All rights reserved.
//

import UIKit

class RotationOverTransitioningAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private let animationDuration: TimeInterval = 1

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
        
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to) else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        
        source.view.frame = transitionContext.containerView.frame
        destination.view.frame = transitionContext.containerView.frame
        
        let originalPosition = destination.view.layer.position
        destination.view.layer.anchorPoint = CGPoint(x: 1, y: 0)
        destination.view.layer.position = CGPoint(x: destination.view.frame.width, y: 0)
        destination.view.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/2)
        
        UIView.animate(withDuration: animationDuration, animations: {
            destination.view.transform = .identity
        }) { completed in
            transitionContext.completeTransition(completed && !transitionContext.transitionWasCancelled)
            destination.view.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            destination.view.layer.position = originalPosition
        }
    }
}

class RotationOffTransitioningAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private let animationDuration: TimeInterval = 1
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
        
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to) else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.bringSubviewToFront(source.view)
        
        source.view.frame = transitionContext.containerView.frame
        destination.view.frame = transitionContext.containerView.frame
        
        let originalPosition = source.view.layer.position
        source.view.layer.anchorPoint = CGPoint(x: 1, y: 0)
        source.view.layer.position = CGPoint(x: source.view.frame.width, y: 0)
        
        UIView.animate(withDuration: animationDuration, animations: {
            source.view.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/2)
        }) { completed in
            transitionContext.completeTransition(completed && !transitionContext.transitionWasCancelled)
            source.view.transform = .identity
            source.view.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            source.view.layer.position = originalPosition
            
        }
    }
}

//
//  UIViewPhotoController.swift
//  vkClient
//
//  Created by Ruslan Guseynov on 08/07/2019.
//  Copyright © 2019 Ruslan Guseynov. All rights reserved.
//

import UIKit

class ViewPhotoController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loadingIndicator: LoadingIndicator!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    
    var isZoomed = false

    var selectedImageId: Int!
    var userPhotosNames: [String]!
    private var animator: UIViewPropertyAnimator!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.bringSubviewToFront(loadingIndicator)
        tabBarController?.tabBar.isHidden = true
        loadingIndicator.isHidden = true
        
        leftImageView.isHidden = true
        rightImageView.isHidden = true
        
        setImages()
        
//        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe(_:)))
//        leftSwipeGesture.direction = .left
//        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe(_:)))
//        rightSwipeGesture.direction = .right
//        imageView.addGestureRecognizer(leftSwipeGesture)
//        imageView.addGestureRecognizer(rightSwipeGesture)
        
        imageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(onPan(_:))))
    }
    
    fileprivate func setImages() {
        guard let image = UIImage(named: userPhotosNames[selectedImageId]) else {
            preconditionFailure("wrong image asset name")
        }
        imageView.image = image
        
        if userPhotosNames.indices.contains(selectedImageId - 1) {
            leftImageView.image = UIImage(named: userPhotosNames[selectedImageId - 1])
        }
        if userPhotosNames.indices.contains(selectedImageId + 1) {
            rightImageView.image = UIImage(named: userPhotosNames[selectedImageId + 1])
        }
    }
    
    @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
//            let isMovingRight = recognizer.translation(in: imageView).x > 0
            let isMovingRight = recognizer.velocity(in: imageView).x > 0
            let newIndex = selectedImageId + (isMovingRight ? -1 : 1)
            guard userPhotosNames.indices.contains(newIndex) else { return }
            
            let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
            let x = (isMovingRight ? 1 : -1) * self.imageView.bounds.width
            print(x)
            let translation = CGAffineTransform(translationX: x, y: 0)
            let scaledTranslation = scale.concatenating(translation)
          
            let newImageView: UIImageView = isMovingRight ? leftImageView : rightImageView
            newImageView.isHidden = false
            
            animator = UIViewPropertyAnimator(duration: 1, curve: .easeInOut, animations: {
                self.imageView.transform = translation
                newImageView.transform = translation
            })
            
//            animator = UIViewPropertyAnimator(duration: 2, curve: .easeInOut, animations: {
//                UIView.animateKeyframes(withDuration: 0.7, delay: 0, options: [.calculationModeCubic, .allowUserInteraction], animations: {
//                    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.4, animations: {
//                        self.imageView.transform = scale
//                    })
//                    UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.8, animations: {
//                        self.imageView.transform = translation
//                        newImageView.transform = translation
//                    })
//                }, completion: nil)
//                { _ in
//                    self.imageView.transform = .identity
//                    newImageView.transform = .identity
//                    self.selectedImageId = newIndex
//                    self.setImages()
//                    newImageView.isHidden = true
//                })
//            })
            
            animator.addCompletion { (position) in
                if position == .end {
                    self.imageView.transform = .identity
                    newImageView.transform = .identity
                    self.selectedImageId = newIndex
                    self.setImages()
                    newImageView.isHidden = true
                }
            }
            
            animator.pauseAnimation()
            
        case .changed:
            let progress = recognizer.translation(in: imageView).x / imageView.bounds.width
            animator.fractionComplete = progress
            
        case .ended:
            animator.continueAnimation(withTimingParameters: .none, durationFactor: 0.3)

        default:
            break
        }
        
//        let isMovingRight = recognizer.translation(in: imageView).x > 0
//
//        switch recognizer.state {
//        case.began:
//
//
//            let newIndex = selectedImageId + (isMovingRight ? -1 : 1)
//
//            guard userPhotosNames.indices.contains(newIndex) else { return }
//
//            let newImageView: UIImageView = isMovingRight ? leftImageView : rightImageView
//            let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
//            let transition = CGAffineTransform(translationX: (isMovingRight ? 1 : -1) * self.imageView.bounds.width, y: 0)
//            let scaledTransition = scale.concatenating(transition)
//
//            animator = UIViewPropertyAnimator(duration: 1, curve: .easeInOut) {
//                self.imageView.transform = scale
//            }
//            animator.addAnimations({
//                self.imageView.transform = scaledTransition
//                newImageView.transform = transition
//            }, delayFactor: 1)
//
//            animator.addCompletion { (position) in
//                guard position == .end else { return }
//
//                self.imageView.transform = .identity
//                self.rightImageView.transform = .identity
//                self.leftImageView.transform = .identity
//                self.selectedImageId = newIndex
//                self.setImages()
//                self.rightImageView.isHidden = true
//                self.leftImageView.isHidden = true
//            }
//
//            animator.pauseAnimation()
//        case .changed:
//            let translation = recognizer.translation(in: imageView)
//            let percent = translation.x / (isMovingRight ? 100 : -100)
//            let animationPercent = min(1, max(0, percent))
//            animator.fractionComplete = animationPercent
//
//        case .ended:
//            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0.4)
//        default:
//            break
//        }
    }
    
    @objc func onSwipe(_ recognizer: UISwipeGestureRecognizer) {
        
        var newIndex: Int = selectedImageId
        switch recognizer.direction {
        case .left:
            newIndex += 1
        case .right:
            newIndex -= 1
        case .up, .down:
            print("Go to previous screen")
        default:
            break
        }

        guard userPhotosNames.indices.contains(newIndex) else { return }

        rightImageView.isHidden = false
        leftImageView.isHidden = false

        let newImageView: UIImageView = recognizer.direction == .left ? rightImageView : leftImageView

        let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
        let translation = CGAffineTransform(translationX: (recognizer.direction == .left ? -1 : 1) * self.imageView.bounds.width, y: 0)
        let scaledTranslation = scale.concatenating(translation)

        UIView.animateKeyframes(withDuration: 0.7, delay: 0, options: [.calculationModeCubic, .allowUserInteraction], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.4, animations: {
                self.imageView.transform = scale
            })
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.8, animations: {
                self.imageView.transform = scaledTranslation
                newImageView.transform = translation
            })
        }, completion: { _ in
            self.imageView.transform = .identity
            newImageView.transform = .identity
            self.selectedImageId = newIndex
            self.setImages()
            self.rightImageView.isHidden = true
            self.leftImageView.isHidden = true
        })
    }

    
    @IBAction func zoomPhoto(_ sender: Any) {
        isZoomed.toggle()
        
        UIView.animate(withDuration: 0.5) {
            if self.isZoomed {
                self.imageView.transform = CGAffineTransform(scaleX: 1.7, y: 1.7)
            } else {
                self.imageView.transform = .identity
            }
        }
    }
}

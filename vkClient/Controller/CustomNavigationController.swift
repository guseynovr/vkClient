//
//  CustomNavigationController.swift
//  vkClient
//
//  Created by Ruslan Guseynov on 04/08/2019.
//  Copyright © 2019 Ruslan Guseynov. All rights reserved.
//

import UIKit

class CustomInteractiveTransition: UIPercentDrivenInteractiveTransition {
    var hasStarted = false
    var shouldFinish = false
}

class CustomNavigationController: UINavigationController {

    let interactiveTransition = CustomInteractiveTransition()
    private let animator = RotationOverTransitioningAnimator()

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        transitioningDelegate = self
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }
}

extension CustomNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            return RotationOverTransitioningAnimator()
        case .pop:
            return RotationOffTransitioningAnimator()
        default:
            return nil
        }
    }
}

extension CustomNavigationController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animator
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animator
    }
}

//
//  PresentMenuAnimator.swift
//  TapIn
//
//  Created by James Daubert on 7/18/17.
//  Copyright © 2017 James Daubert. All rights reserved.
//

import UIKit

class PresentMenuAnimator : NSObject {
}

extension PresentMenuAnimator : UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let containerView = transitionContext.containerView,
            
        containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
            else {
                return
        }
        // more code goes here
    }
}

//
//  PresentMenuAnimator.swift
//  TapIn
//
//  Created by James Daubert on 7/22/17.
//  Copyright © 2017 James Daubert. All rights reserved.
//

//import UIKit
//
//class PresentMenuAnimator: NSObject {
//}
//
//extension PresentMenuAnimator: UIViewControllerAnimatedTransitioning {
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return 0.6
//    }
//    
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        let containerView = transitionContext.containerView
//        guard
//            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
//            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
//            else {
//                return
//            }
//        containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
//        //snapshot is image of home view, so that user can't interact w it while in menu
//        let snapshot = fromVC.view.snapshotView(afterScreenUpdates: false)
//        snapshot?.tag = MenuHelper.snapshotNumber
//        snapshot?.isUserInteractionEnabled = false
//        snapshot?.layer.shadowOpacity = 0.7
//        containerView.insertSubview(snapshot!, aboveSubview: toVC.view)
//        fromVC.view.isHidden = true
//        let transitionDur = transitionDuration(using: transitionContext)
//        UIView.animate(withDuration: transitionDur,
//                       animations: {
//                            snapshot?.center.x += UIScreen.main.bounds.width * MenuHelper.menuWidth
//                        },
//                       completion: { _ in
//                        fromVC.view.isHidden = false
//                        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//                        })
//        
//    }
//}

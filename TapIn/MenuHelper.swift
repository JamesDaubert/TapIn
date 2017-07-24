////
////  MenuHelper.swift
////  TapIn
////
////  Created by James Daubert on 7/22/17.
////  Copyright © 2017 James Daubert. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//enum Direction {
//    case Left
//    case Right
//}
//
//struct MenuHelper {
//    
//    static let menuWidth: CGFloat = 0.8
//    static let percentThreshold: CGFloat = 0.3
//    static let snapshotNumber = 12345
//    
//}
//
////p1 = touch loc., p2 = screen dimensions, p3 = direction of slideout
//func caclulateProgress(translationInView: CGPoint, viewBounds: CGRect, direction: Direction) -> CGFloat {
//    let pointOnAxis: CGFloat
//    let axisLength: CGFloat
//    switch direction {
//    case .Left, .Right:
//        pointOnAxis = translationInView.x
//        axisLength = viewBounds.width
//    }
//    let movementOnAxis = pointOnAxis / axisLength
//    let positiveMovementOnAxis: Float
//    let positiveMovementOnAxisPercent: Float
//    switch direction {
//    case .Right: // positive
//        positiveMovementOnAxis = fmaxf(Float(movementOnAxis), 0.0)
//        positiveMovementOnAxisPercent = fminf(positiveMovementOnAxis, 1.0)
//        return CGFloat(positiveMovementOnAxisPercent)
//    case .Left: // negative
//        positiveMovementOnAxis = fminf(Float(movementOnAxis), 0.0)
//        positiveMovementOnAxisPercent = fmaxf(positiveMovementOnAxis, -1.0)
//        return CGFloat(-positiveMovementOnAxisPercent)
//    }
//}
//
//func mapGestureStateToInteractor(gestureState: UIGestureRecognizerState, progress: CGFloat, interactor: Interactor?, triggerSegue: () -> Void) {
//    guard let interactor = interactor else { return }
//    switch gestureState {
//    case .began:
//        interactor.hasStarted = true
//        triggerSegue()
//    case .changed:
//        interactor.shouldFinish = progress > MenuHelper.percentThreshold
//        interactor.update(progress)
//    case .cancelled:
//        interactor.hasStarted = false
//        interactor.cancel()
//    case .ended:
//        interactor.hasStarted = false
//        interactor.shouldFinish
//            ? interactor.finish()
//            : interactor.cancel()
//    default:
//        break
//    }
//}

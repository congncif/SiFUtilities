//
//  UIView+Animation.swift
//  Pods-SiFUtilities_Example
//
//  Created by FOLY on 2/6/18.
//

import Foundation
import UIKit

extension UIView {
    public func animate(duration: Double = 0.25,
                        transitionType: String = kCATransitionMoveIn,
                        direction: String = kCATransitionFromLeft,
                        key: String = "animation") {
        let transition = CATransition()
        transition.duration = duration
        transition.type = transitionType
        transition.subtype = direction
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.isRemovedOnCompletion = true
        layer.add(transition, forKey: key)
    }
    
    public func fade(_ duration: Double = 0.25) {
        animate(duration: duration, transitionType: kCATransitionFade, direction: kCATransitionFromLeft)
    }
    
    public func moveInFromLeft(_ duration: Double = 0.25) {
        animate(duration: duration, transitionType: kCATransitionMoveIn, direction: kCATransitionFromLeft)
    }
    
    public func moveInFromRight(_ duration: Double = 0.25) {
        animate(duration: duration, transitionType: kCATransitionMoveIn, direction: kCATransitionFromRight)
    }
    
    public func moveInFromTop(_ duration: Double = 0.25) {
        animate(duration: duration, transitionType: kCATransitionMoveIn, direction: kCATransitionFromTop)
    }
    
    public func moveInFromBottom(_ duration: Double = 0.25) {
        animate(duration: duration, transitionType: kCATransitionMoveIn, direction: kCATransitionFromBottom)
    }
    
    public func pushFromLeft(_ duration: Double = 0.25) {
        animate(duration: duration, transitionType: kCATransitionPush, direction: kCATransitionFromLeft)
    }
    
    public func pushFromRight(_ duration: Double = 0.25) {
        animate(duration: duration, transitionType: kCATransitionPush, direction: kCATransitionFromRight)
    }
    
    public func pushFromTop(_ duration: Double = 0.25) {
        animate(duration: duration, transitionType: kCATransitionPush, direction: kCATransitionFromTop)
    }
    
    public func pushFromBottom(_ duration: Double = 0.25) {
        animate(duration: duration, transitionType: kCATransitionPush, direction: kCATransitionFromBottom)
    }
    
    public func revealFromLeft(_ duration: Double = 0.25) {
        animate(duration: duration, transitionType: kCATransitionReveal, direction: kCATransitionFromLeft)
    }
    
    public func revealFromRight(_ duration: Double = 0.25) {
        animate(duration: duration, transitionType: kCATransitionReveal, direction: kCATransitionFromRight)
    }
    
    public func revealFromTop(_ duration: Double = 0.25) {
        animate(duration: duration, transitionType: kCATransitionReveal, direction: kCATransitionFromTop)
    }
    
    public func revealFromBottom(_ duration: Double = 0.25) {
        animate(duration: duration, transitionType: kCATransitionReveal, direction: kCATransitionFromBottom)
    }
}

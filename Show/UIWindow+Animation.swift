//
//  UIWindow+Animation.swift
//  Pods
//
//  Created by NGUYEN CHI CONG on 8/22/20.
//

import Foundation
import UIKit

extension UIWindow {
    public func setRootViewController(_ rootViewController: UIViewController, animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        if let presented = self.rootViewController?.presentedViewController {
            presented.modalTransitionStyle = .crossDissolve
            self.rootViewController?.dismiss(animated: animated, completion: {
                self.setRootViewController(rootViewController, animated: animated, completion: completion)
            })
            return
        }
        if animated {
            transitRootViewController(rootViewController, duration: 0.3, options: .transitionCrossDissolve)
        } else {
            self.rootViewController = rootViewController
        }
    }

    public func transitRootViewController(_ rootViewController: UIViewController, duration: TimeInterval, options: UIView.AnimationOptions, completion: ((Bool) -> Void)? = nil) {
        self.rootViewController = rootViewController
        UIView.transition(with: self,
                          duration: duration,
                          options: options,
                          animations: {},
                          completion: completion)
    }
}

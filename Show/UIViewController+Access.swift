//
//  UIViewController+Top.swift
//  SiFUtilities
//
//  Created by NGUYEN CHI CONG on 8/18/20.
//

import Foundation
import UIKit

extension UITabBarController {
    @objc override var topMostViewController: UIViewController {
        return selectedViewController?.topMostViewController ?? self
    }
}

extension UINavigationController {
    @objc override var topMostViewController: UIViewController {
        return topViewController?.topMostViewController ?? self
    }
}

extension UIViewController {
    @objc var topMostViewController: UIViewController {
        return self
    }
}

extension UIViewController {
    public var allPresentedViewControllers: [UIViewController] {
        if let presented = presentedViewController {
            return presented.allPresentedViewControllers + [presented]
        } else {
            return []
        }
    }

    public var allPresentingViewControllers: [UIViewController] {
        if let presenting = presentingViewController {
            return [presenting] + presenting.allPresentingViewControllers
        } else {
            return []
        }
    }

    public var topPresentedViewController: UIViewController {
        let topBasic = allPresentedViewControllers.last?.topMostViewController ?? self
        if topBasic.presentedViewController == nil { return topBasic }
        return topBasic.topPresentedViewController
    }
}

extension UINavigationController {
    public var rootViewController: UIViewController? {
        return viewControllers.first
    }
}

extension UIViewController {
    public var oldestParent: UIViewController {
        if let parent = self.parent {
            return parent.oldestParent
        } else {
            return self
        }
    }
}

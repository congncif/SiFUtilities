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
        return presentedViewController?.topMostViewController ?? selectedViewController?.topMostViewController ?? self
    }
}

extension UINavigationController {
    @objc override var topMostViewController: UIViewController {
        return presentedViewController?.topMostViewController ?? topViewController?.topMostViewController ?? self
    }
}

extension UIViewController {
    @objc var topMostViewController: UIViewController {
        return presentedViewController?.topMostViewController ?? self
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
        tabBarController?.topMostViewController ?? navigationController?.topMostViewController ?? topMostViewController
    }
}

extension UINavigationController {
    public var rootViewController: UIViewController? {
        return viewControllers.first
    }
}

extension UIViewController {
    public var oldestLineageViewController: UIViewController {
        if let parent = self.parent {
            return parent.oldestLineageViewController
        } else {
            return self
        }
    }

    public var allParents: [UIViewController] {
        if let parent = self.parent {
            return [parent] + parent.allParents
        } else {
            return []
        }
    }

    public var olderLineageViewControllers: [UIViewController] {
        allParents + [self]
    }
}

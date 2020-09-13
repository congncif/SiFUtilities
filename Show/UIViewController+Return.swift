//
//  UIViewController+Return.swift
//  SiFUtilities
//
//  Created by NGUYEN CHI CONG on 8/18/20.
//

import Foundation
import UIKit

extension UIViewController {
    public func returnHere(animated: Bool = true, completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        if self.presentedViewController != nil {
            self.dismiss(animated: animated)
        }
        self.popToShowIfNeeded(animated: animated)
        CATransaction.commit()
    }

    private func popToShowIfNeeded(animated: Bool) {
        if let nav = navigationController, let foundTarget = findParentViewController(in: nav) {
            nav.popToViewController(foundTarget, animated: animated)
        }
    }

    private func findParentViewController(in navigationController: UINavigationController) -> UIViewController? {
        if navigationController.viewControllers.contains(self) {
            return self
        } else {
            return allParents.first { navigationController.viewControllers.contains($0) }
        }
    }
}

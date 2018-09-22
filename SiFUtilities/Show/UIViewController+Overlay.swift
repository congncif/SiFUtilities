//
//  UIViewController+Child.swift
//
//
//  Created by FOLY on 2/20/18.
//  Copyright © 2018 [iF] Solution. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    @objc public func displayContentController(content: UIViewController,
                                               animation: ((_ container: UIView, _ overlay: UIView) -> Void)? = { container, _ in container.fade() }) {
        addChild(content)
        content.view.frame = view.bounds
        content.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(content.view)
        animation?(view, content.view)
        content.didMove(toParent: self)
    }

    @objc public func hideContentController(content: UIViewController,
                                            animation: ((_ container: UIView, _ overlay: UIView) -> Void)? = { container, _ in container.fade() }) {
        content.willMove(toParent: nil)
        let superView = content.view.superview ?? view!
        animation?(superView, view)
        content.view.removeFromSuperview()
        content.removeFromParent()
    }

    @objc public func showOverlay(on viewController: UIViewController,
                                  animation: ((_ container: UIView, _ overlay: UIView) -> Void)? = { container, _ in container.fade() }) {
        viewController.displayContentController(content: self, animation: animation)
    }

    @objc public func hideOverlay(animation: ((_ container: UIView, _ overlay: UIView) -> Void)? = { container, _ in container.fade() }) {
        willMove(toParent: nil)
        let superView = view.superview ?? view!
        animation?(superView, view)
        view.removeFromSuperview()
        removeFromParent()
    }
}

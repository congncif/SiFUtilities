//
//  UIViewController+Show.swift
//  Pods
//
//  Created by FOLY on 7/14/17.
//
//

import Foundation

import UIKit

extension UIViewController {
    public func show(on baseViewController: UIViewController) {
        if let navigation = baseViewController as? UINavigationController {
            navigation.pushViewController(self, animated: true)
        } else {
            baseViewController.present(self, animated: true, completion: nil)
        }
    }
    
    public func show(viewController: UIViewController, from baseviewController: UIViewController? = nil) {
        guard let base = baseviewController else {
            if let navigation = self.navigationController {
                viewController.show(on: navigation)
            } else {
                viewController.show(on: self)
            }
            return
        }
        viewController.show(on: base)
    }
}

//
//  UIViewController+Loading.swift
//  SiFUtilities
//
//  Created by FOLY on 9/22/18.
//

import Foundation
import UIKit

extension UIViewController {
    // MARK: - Loading

    @objc open func showLoading(animated: Bool = false) {
        self.view.showLoading(animated: animated)
    }

    @objc open func hideLoading(animated: Bool = false) {
        self.view.hideLoading(animated: animated)
    }
}

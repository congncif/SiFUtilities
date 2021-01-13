//
//  UIViewController++.swift
//  SiFUtilities
//
//  Created by NGUYEN CHI CONG on 7/13/19.
//

import Foundation
import UIKit

extension UIViewController {
    public var activeNavigationBar: UINavigationBar? {
        if let navigator = self as? UINavigationController {
            return navigator.navigationBar
        } else {
            return navigationController?.navigationBar
        }
    }
}

// MARK: - Navigation

extension UIViewController {
    public func setNavigationBarTitle(_ title: String) {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = activeNavigationBar?.tintColor ?? .black
        label.text = title
        label.sizeToFit()
        navigationItem.titleView = label
    }
    
    public func setNavigationBarHighlightedColor(_ color: UIColor) {
        activeNavigationBar?.setHighlightColor(color)
        activeNavigationBar?.layoutIfNeeded()
    }
    
    public func setNavigationBarBackImage(_ image: UIImage) {
        activeNavigationBar?.setBackImage(image)
    }
    
    public func setNavigationBarBackTitle(_ title: String) {
        let backItem = UIBarButtonItem.plainBarButtonItem(title: title)
        
        /// should call before push new item to fix issue previous item back title not set
        activeNavigationBar?.topItem?.backBarButtonItem = backItem
        
        navigationItem.backBarButtonItem = backItem
    }
    
    public func hideNavigationBarBackTitle() {
        setNavigationBarBackTitle("")
    }
    
    public func setNavigationBarBorderHidden(_ isHidden: Bool) {
        let image = isHidden ? UIImage() : nil
        activeNavigationBar?.shadowImage = image
    }
}

//
//  UIViewController++.swift
//  SiFUtilities
//
//  Created by NGUYEN CHI CONG on 7/13/19.
//

import Foundation
import UIKit

extension UIViewController {
    public var navigationBar: UINavigationBar? {
        return navigationController?.navigationBar
    }
}

// MARK: - Navigation

extension UIViewController {
    public func setNavigationBarTitle(_ title: String) {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = navigationBar?.tintColor ?? .black
        label.text = title
        label.sizeToFit()
        navigationItem.titleView = label
    }
    
    public func setNavigationBarHighlightedColor(_ color: UIColor) {
        navigationBar?.setHighlightColor(color)
        navigationBar?.layoutIfNeeded()
    }
    
    public func setNavigationBarBackImage(_ image: UIImage) {
        navigationBar?.setBackImage(image)
    }
    
    public func setNavigationBarBackTitle(_ title: String) {
        let backItem = UIBarButtonItem.plainBarButtonItem(title: title)
        
        /// should call before push new item to fix issue previous item back title not set
        navigationBar?.topItem?.backBarButtonItem = backItem
        
        navigationItem.backBarButtonItem = backItem
    }
    
    public func hideNavigationBarBackTitle() {
        setNavigationBarBackTitle("")
    }
    
    public func setNavigationBarBorderHidden(_ isHidden: Bool) {
        let image = isHidden ? UIImage() : nil
        navigationBar?.shadowImage = image
    }
}

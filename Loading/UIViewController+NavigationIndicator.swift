//
//  UIViewController+NavigationIndicator.swift
//  SiFUtilities
//
//  Created by NGUYEN CHI CONG on 9/28/21.
//  Copyright © 2021 [iF] Solution. All rights reserved.
//

import Foundation
import UIKit

private var rightItemsKey: UInt8 = 70
private var titleViewKey: UInt8 = 71

extension UIViewController {
    private var rightItems: [UIBarButtonItem]? {
        get {
            getAssociatedObject(key: &rightItemsKey)
        }

        set {
            setAssociatedObject(key: &rightItemsKey, value: newValue)
        }
    }
    
    private var titleView: UIView? {
        get {
            getAssociatedObject(key: &titleViewKey)
        }

        set {
            setAssociatedObject(key: &titleViewKey, value: newValue)
        }
    }
    
    public enum NavigationLoadingStyle {
        case right
        case center
    }
    
    public func showNavigationLoading(style: NavigationLoadingStyle = .center, animated: Bool = true) {
        var indicatorStyle: UIActivityIndicatorView.Style
        if #available(iOS 13, *) {
            indicatorStyle = .medium
        } else {
            indicatorStyle = .gray
        }
        
        let activityIndicator = UIActivityIndicatorView(style: indicatorStyle)
        activityIndicator.tintColor = .darkGray
        
        switch style {
        case .right:
            rightItems = navigationItem.rightBarButtonItems
            
            let barButtonItem = UIBarButtonItem(customView: activityIndicator)
            navigationItem.setRightBarButton(barButtonItem, animated: animated)
            
        case .center:
            titleView = navigationItem.titleView
            
            navigationItem.titleView = activityIndicator
        }
        activityIndicator.startAnimating()
    }
    
    public func hideNavigationLoading(style: NavigationLoadingStyle = .center, animated: Bool = true) {
        switch style {
        case .right:
            navigationItem.setRightBarButtonItems(rightItems, animated: animated)
            rightItems = nil
        case .center:
            navigationItem.titleView = titleView
            titleView = nil
        }
    }
}

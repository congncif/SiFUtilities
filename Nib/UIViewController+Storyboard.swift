//
//  UIViewController+Storyboard.swift
//  SiFUtilities
//
//  Created by FOLY on 1/11/17.
//  Copyright © 2017 [iF] Solution. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    public struct Name {
        static let main = "Main"
    }
    
    open var main: UIStoryboard {
        return UIStoryboard(name: Name.main, bundle: nil)
    }
    
    public convenience init(name: String) {
        self.init(name: name, bundle: nil)
    }
}

extension UIViewController {
    fileprivate class func instantiateFromStoryboardHelper<T>(storyboardName: String,
                                                              storyboardId: String,
                                                              bundle: Bundle? = nil) -> T {
        let _bundle = bundle ?? Bundle(for: self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: _bundle)
        guard let controller = storyboard.instantiateViewController(withIdentifier: storyboardId) as? T else {
            preconditionFailure("Cannot instantiate \(T.self) with identifier \(storyboardId) from storyboard \(storyboardName)")
        }
        return controller
    }
    
    fileprivate class func instantiateFromStoryboardHelper<T>(storyboardName: String,
                                                              bundle: Bundle? = nil) -> T {
        let _bundle = bundle ?? Bundle(for: self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: _bundle)
        let controller = storyboard.instantiateInitialViewController() as! T
        return controller
    }
    
    open class func instantiateFromStoryboard(name: String,
                                              identifier: String,
                                              bundle: Bundle? = nil) -> Self {
        return instantiateFromStoryboardHelper(storyboardName: name,
                                               storyboardId: identifier,
                                               bundle: bundle)
    }
    
    open class func instantiateFromStoryboard(name: String,
                                              bundle: Bundle? = nil) -> Self {
        let identifier = className
        return instantiateFromStoryboardHelper(storyboardName: name, storyboardId: identifier, bundle: bundle)
    }
    
    open class func instantiateFromStoryboard(bundle: Bundle? = nil) -> Self {
        let name = className
        let identifier = className
        return instantiateFromStoryboardHelper(storyboardName: name, storyboardId: identifier, bundle: bundle)
    }
    
    open class func instantiateFromModuleStoryboard(bundle: Bundle? = nil) -> Self {
        let name = className.replacingOccurrences(of: "ViewController", with: "")
        let identifier = className
        return instantiateFromStoryboardHelper(storyboardName: name, storyboardId: identifier, bundle: bundle)
    }
    
    open class func instantiateFromMainStoryboard(identifier: String, bundle: Bundle? = nil) -> Self {
        return instantiateFromStoryboard(name: UIStoryboard.Name.main, identifier: identifier, bundle: bundle)
    }
    
    open class func instantiateFromMainStoryboard(bundle: Bundle? = nil) -> Self {
        let identifier = className
        return instantiateFromStoryboard(name: UIStoryboard.Name.main, identifier: identifier, bundle: bundle)
    }
    
    open class func instantiateInitialFromStoryboard(name: String, bundle: Bundle? = nil) -> Self {
        return instantiateFromStoryboardHelper(storyboardName: name, bundle: bundle)
    }
    
    open class func instantiateInitialFromStoryboard(bundle: Bundle? = nil) -> Self {
        let name = className
        return instantiateFromStoryboardHelper(storyboardName: name, bundle: bundle)
    }
    
    open class func instantiateInitialFromModuleStoryboard(bundle: Bundle? = nil) -> Self {
        let name = className.replacingOccurrences(of: "ViewController", with: "")
        return instantiateFromStoryboardHelper(storyboardName: name, bundle: bundle)
    }
    
    open func navigationContainer<U: UINavigationController>() -> U? {
        return navigationController as? U
    }
    
    open func tabBarContainer<U: UITabBarController>() -> U? {
        return tabBarController as? U
    }
    
    /**
     Init with storyboard path
     
     - parameter storyboardPath: <storyboard file name>.<storyboard identifier>
     
     - returns: instance of this class
     */
    open class func instantiateViewController(storyboardPath: String,
                                              separator: String = ".",
                                              bundle: Bundle? = nil) -> Self {
        let components = storyboardPath.components(separatedBy: separator)
        
        guard !components.isEmpty, components.count < 3 else { return self.init() }
        
        if components.count == 1 {
            return instantiateFromMainStoryboard(identifier: storyboardPath, bundle: bundle)
        } else {
            let storyboardName = components[0]
            let storyboardId = components[1]
            return instantiateFromStoryboardHelper(storyboardName: storyboardName,
                                                   storyboardId: storyboardId,
                                                   bundle: bundle)
        }
    }
}

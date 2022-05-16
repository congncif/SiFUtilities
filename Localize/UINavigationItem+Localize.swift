//
//  UINavigationItem+Localize.swift
//  SiFUtilities
//
//  Created by FOLY on 12/8/18.
//

import Foundation
import UIKit

// @IBDesignable
extension UINavigationItem {
    @IBInspectable public var titleLocalizedKey: String? {
        get {
            return getStringValue(by: &RunTimeKey.localizedTitleKey)
        }
        
        set {
            setStringValue(newValue, forRuntimeKey: &RunTimeKey.localizedTitleKey)
        }
    }
    
    @IBInspectable public var backTitleLocalizedKey: String? {
        get {
            return getStringValue(by: &RunTimeKey.localizedBackTitleKey)
        }
        
        set {
            setStringValue(newValue, forRuntimeKey: &RunTimeKey.localizedBackTitleKey)
        }
    }
    
    @objc override open func updateLocalize(attributes: [LocalizedKey: String]) {
        if let value = attributes[.localizedTitleKey]?.localized {
            title = value
        }
        
        if let value = attributes[.localizedBackTitleKey]?.localized {
            let backItem = UIBarButtonItem.plainBarButtonItem(title: value)
            backBarButtonItem = backItem
        }
    }
    
    @objc override open func updateLanguage() {
        if let key = titleLocalizedKey {
            updateLocalize(attributes: [.localizedTitleKey: key])
        }
        
        if let key = backTitleLocalizedKey {
            updateLocalize(attributes: [.localizedBackTitleKey: key])
        }
    }
}

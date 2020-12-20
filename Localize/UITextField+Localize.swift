//
//  UITextField+Localize.swift
//  SiFUtilities
//
//  Created by FOLY on 12/8/18.
//

import Foundation
import UIKit

// @IBDesignable
extension UITextField: AssociatedObject {
    @IBInspectable public var placeholderLocalizedKey: String? {
        get {
            return getStringValue(by: &RunTimeKey.localizedPlaceholderTextKey)
        }
        
        set {
            setStringValue(newValue, forRuntimeKey: &RunTimeKey.localizedPlaceholderTextKey)
        }
    }
    
    @IBInspectable public var textLocalizedKey: String? {
        get {
            return getAssociatedObject(key: &RunTimeKey.localizedTextKey)
        }
        
        set {
            if let value = newValue, !newValue.isNoValue {
                setAssociatedObject(key: &RunTimeKey.localizedTextKey, value: value)
                
                registerLocalizeUpdateNotification()
            }
        }
    }
    
    @objc override open func updateLocalize(attributes: [LocalizedKey: String]) {
        if let text = attributes[.localizedTextKey]?.localized {
            self.text = text
        }
        
        if let text = attributes[.localizedPlaceholderTextKey]?.localized {
            placeholder = text
        }
    }
    
    @objc override open func updateLanguage() {
        if let key = textLocalizedKey {
            updateLocalize(attributes: [.localizedTextKey: key])
        }
        
        if let key = placeholderLocalizedKey {
            updateLocalize(attributes: [.localizedPlaceholderTextKey: key])
        }
    }
}

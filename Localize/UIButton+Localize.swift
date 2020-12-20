//
//  UIButton+Localize.swift
//  SiFUtilities
//
//  Created by FOLY on 12/8/18.
//

import Foundation
import UIKit

// @IBDesignable
extension UIButton: AssociatedObject {
    @IBInspectable public var normalTitleLocalizedKey: String? {
        get {
            return getStringValue(by: &RunTimeKey.localizedNormalTitleKey)
        }
        
        set {
            setStringValue(newValue, forRuntimeKey: &RunTimeKey.localizedNormalTitleKey)
        }
    }
    
    @IBInspectable public var selectedTitleLocalizedKey: String? {
        get {
            return getStringValue(by: &RunTimeKey.localizedSelectedTitleKey)
        }
        
        set {
            setStringValue(newValue, forRuntimeKey: &RunTimeKey.localizedSelectedTitleKey)
        }
    }
    
    @objc override open func updateLocalize(attributes: [LocalizedKey: String]) {
        if let normalTitle = attributes[.localizedNormalTitleKey]?.localized {
            setTitle(normalTitle, for: .normal)
        }
        
        if let selectedTitle = attributes[.localizedSelectedTitleKey]?.localized {
            setTitle(selectedTitle, for: .selected)
        }
    }
    
    @objc override open func updateLanguage() {
        if let key = normalTitleLocalizedKey {
            updateLocalize(attributes: [.localizedNormalTitleKey: key])
        }
        
        if let key = selectedTitleLocalizedKey {
            updateLocalize(attributes: [.localizedSelectedTitleKey: key])
        }
    }
}

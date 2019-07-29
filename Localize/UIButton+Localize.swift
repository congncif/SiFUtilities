//
//  UIButton+Localize.swift
//  SiFUtilities
//
//  Created by FOLY on 12/8/18.
//

import Foundation
import UIKit

@IBDesignable extension UIButton: AssociatedObject {
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
    
    @objc open override func updateLocalize(attributes: [UInt8: String]) {
        setTitle(attributes[.localizedNormalTitleKey]?.localized, for: .normal)
        setTitle(attributes[.localizedSelectedTitleKey]?.localized, for: .selected)
    }
}

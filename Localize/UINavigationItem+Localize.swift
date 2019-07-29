//
//  UINavigationItem+Localize.swift
//  SiFUtilities
//
//  Created by FOLY on 12/8/18.
//

import Foundation
import UIKit

@IBDesignable extension UINavigationItem: AssociatedObject {
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
    
    @objc open override func updateLocalize(attributes: [UInt8: String]) {
        title = attributes[.localizedTitleKey]?.localized
        backBarButtonItem?.title = attributes[.localizedBackTitleKey]?.localized
    }
}

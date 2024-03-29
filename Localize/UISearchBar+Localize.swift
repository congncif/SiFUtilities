//
//  UISearchBar+Localize.swift
//  SiFUtilities
//
//  Created by FOLY on 12/8/18.
//

import Foundation
import UIKit

// @IBDesignable
extension UISearchBar {
    @IBInspectable public var placeholderLocalizedKey: String? {
        get {
            return getStringValue(by: &RunTimeKey.localizedPlaceholderTextKey)
        }

        set {
            setStringValue(newValue, forRuntimeKey: &RunTimeKey.localizedPlaceholderTextKey)
        }
    }

    @objc override open func updateLocalize(attributes: [LocalizedKey: String]) {
        if let text = attributes[.localizedPlaceholderTextKey]?.localized {
            placeholder = text
        }
    }

    @objc override open func updateLanguage() {
        if let key = placeholderLocalizedKey {
            updateLocalize(attributes: [.localizedPlaceholderTextKey: key])
        }
    }
}

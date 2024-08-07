//
//  UIControl+Localize.swift
//  SiFUtilities
//
//  Created by FOLY on 11/17/18.
//

import Foundation
import UIKit

// @IBDesignable
extension UILabel {
    @IBInspectable open var textLocalizedKey: String? {
        get {
            return getStringValue(by: &RunTimeKey.localizedTextKey)
        }

        set {
            setStringValue(newValue, forRuntimeKey: &RunTimeKey.localizedTextKey)
        }
    }

    @objc override open func updateLocalize(attributes: [LocalizedKey: String]) {
        text = attributes[.localizedTextKey]?.localized
    }

    @objc override open func updateLanguage() {
        if let key = textLocalizedKey {
            updateLocalize(attributes: [.localizedTextKey: key])
        }
    }
}

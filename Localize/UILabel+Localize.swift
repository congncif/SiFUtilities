//
//  UIControl+Localize.swift
//  SiFUtilities
//
//  Created by FOLY on 11/17/18.
//

import Foundation
import UIKit

@IBDesignable extension UILabel: AssociatedObject {
    @IBInspectable open var textLocalizedKey: String? {
        get {
            return getStringValue(by: &RunTimeKey.localizedTextKey)
        }

        set {
            setStringValue(newValue, forRuntimeKey: &RunTimeKey.localizedTextKey)
        }
    }

    @objc open override func updateLocalize(attributes: [LocalizedKey: String]) {
        text = attributes[.localizedTextKey]?.localized
    }

    @objc open override func updateLanguage() {
        if let key = textLocalizedKey {
            updateLocalize(attributes: [.localizedTextKey: key])
        }
    }
}

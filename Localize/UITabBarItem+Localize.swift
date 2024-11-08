//
//  UITabBarItem+Localize.swift
//  SiFUtilities
//
//  Created by FOLY on 12/8/18.
//

import Foundation
import UIKit

// @IBDesignable
extension UITabBarItem {
    @IBInspectable public var titleLocalizedKey: String? {
        get {
            return getStringValue(by: &RunTimeKey.localizedTitleKey)
        }

        set {
            setStringValue(newValue, forRuntimeKey: &RunTimeKey.localizedTitleKey)
        }
    }

    @objc override open func updateLocalize(attributes: [LocalizedKey: String]) {
        if let text = attributes[.localizedTitleKey]?.localized {
            title = text
        }
    }

    @objc override open func updateLanguage() {
        if let key = titleLocalizedKey {
            updateLocalize(attributes: [.localizedTitleKey: key])
        }
    }
}

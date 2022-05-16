//
//  UIBarButtonItem+Localize.swift
//  SiFUtilities
//
//  Created by FOLY on 12/8/18.
//

import Foundation
import UIKit

//@IBDesignable
extension UIBarButtonItem {
    @IBInspectable public var titleLocalizedKey: String? {
        get {
            return getStringValue(by: &RunTimeKey.localizedTitleKey)
        }

        set {
            setStringValue(newValue, forRuntimeKey: &RunTimeKey.localizedTitleKey)
        }
    }

    @objc open override func updateLocalize(attributes: [LocalizedKey: String]) {
        if let value = attributes[.localizedTitleKey]?.localized {
            title = value
        }
    }

    @objc open override func updateLanguage() {
        if let key = titleLocalizedKey {
            updateLocalize(attributes: [.localizedTitleKey: key])
        }
    }
}

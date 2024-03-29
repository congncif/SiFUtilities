//
//  UISegmentControl+Localize.swift
//  SiFUtilities
//
//  Created by FOLY on 12/8/18.
//

import Foundation
import UIKit

/// The segment titles are separated by single character ',' (no space). For example: 'title1,title2,title3'

// @IBDesignable
extension UISegmentedControl {
    @IBInspectable public var titlesLocalizedKey: String? {
        get {
            return getStringValue(by: &RunTimeKey.localizedArrayKey)
        }

        set {
            setStringValue(newValue, forRuntimeKey: &RunTimeKey.localizedArrayKey)
        }
    }

    @objc override open func updateLocalize(attributes: [LocalizedKey: String]) {
        if let value = attributes[.localizedTitleKey] {
            let components = value.components(separatedBy: ",")
            for i in 0 ..< numberOfSegments {
                if i < components.count {
                    let title = components[i]
                    setTitle(title.localized, forSegmentAt: i)
                }
            }
        }
    }

    @objc override open func updateLanguage() {
        if let key = titlesLocalizedKey {
            updateLocalize(attributes: [.localizedTitleKey: key])
        }
    }
}

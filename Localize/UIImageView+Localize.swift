//
//  UIImageView++.swift
//  SiFUtilities
//
//  Created by FOLY on 9/10/18.
//

import Foundation

// @IBDesignable
extension UIImageView {
    @IBInspectable public var imageNameLocalizedKey: String? {
        get {
            return getStringValue(by: &RunTimeKey.localizedImageNameKey)
        }

        set {
            setStringValue(newValue, forRuntimeKey: &RunTimeKey.localizedImageNameKey)
        }
    }

    @objc override open func updateLocalize(attributes: [LocalizedKey: String]) {
        if let imageName = attributes[.localizedImageNameKey]?.localized {
            let assetImage = UIImage(named: imageName)
            image = assetImage
        }
    }

    @objc override open func updateLanguage() {
        if let key = imageNameLocalizedKey {
            updateLocalize(attributes: [.localizedImageNameKey: key])
        }
    }
}

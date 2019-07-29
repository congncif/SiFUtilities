//
//  UIImageView++.swift
//  SiFUtilities
//
//  Created by FOLY on 9/10/18.
//

import Foundation

@IBDesignable extension UIImageView: AssociatedObject {
    @IBInspectable public var imageNameLocalizedKey: String? {
        get {
            return getStringValue(by: &RunTimeKey.localizedImageNameKey)
        }

        set {
            setStringValue(newValue, forRuntimeKey: &RunTimeKey.localizedImageNameKey)
        }
    }

    @objc open override func updateLocalize(attributes: [UInt8: String]) {
        if let imageName = attributes[.localizedImageNameKey]?.localized {
            let assetImage = UIImage(named: imageName)
            image = assetImage
        }
    }
}

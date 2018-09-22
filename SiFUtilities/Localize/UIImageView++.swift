//
//  UIImageView++.swift
//  SiFUtilities
//
//  Created by FOLY on 9/10/18.
//

import Foundation

@IBDesignable extension UIImageView {
    @IBInspectable public var imageName: String? {
        get {
            return nil // ignore
        }

        set {
            if let name = newValue {
                let assetImage = UIImage(named: name)
                image = assetImage
            }
        }
    }
}

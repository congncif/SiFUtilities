//
//  UIControl+Localize.swift
//  SiFUtilities
//
//  Created by FOLY on 11/17/18.
//

import Foundation
import UIKit

@IBDesignable extension UILabel {
    @IBInspectable public var localizedTextKey: String? {
        get {
            return nil // ignore
        }
        
        set {
            text = newValue?.localized
        }
    }
}

@IBDesignable extension UITextField {
    @IBInspectable public var localizedPlaceholderKey: String? {
        get {
            return nil // ignore
        }
        
        set {
            placeholder = newValue?.localized
        }
    }
    
    @IBInspectable public var localizedTextKey: String? {
        get {
            return nil // ignore
        }
        
        set {
            text = newValue?.localized
        }
    }
}

@IBDesignable extension UITextView {
    @IBInspectable public var localizedTextKey: String? {
        get {
            return nil // ignore
        }
        
        set {
            text = newValue?.localized
        }
    }
}

@IBDesignable extension UIButton {
    @IBInspectable public var localizedNormalTitleKey: String? {
        get {
            return nil // ignore
        }
        
        set {
            setTitle(newValue?.localized, for: .normal)
        }
    }
    
    @IBInspectable public var localizedSelectedTitleKey: String? {
        get {
            return nil // ignore
        }
        
        set {
            setTitle(newValue?.localized, for: .selected)
        }
    }
}

@IBDesignable extension UINavigationItem {
    @IBInspectable public var localizedTitleKey: String? {
        get {
            return nil // ignore
        }
        
        set {
            title = newValue?.localized
        }
    }
    
    @IBInspectable public var localizedBackButtonTitleKey: String? {
        get {
            return nil // ignore
        }
        
        set {
            backBarButtonItem?.title = newValue?.localized
        }
    }
}

@IBDesignable extension UIViewController {
    @IBInspectable public var localizedTitleKey: String? {
        get {
            return nil // ignore
        }
        
        set {
            title = newValue?.localized
        }
    }
}

@IBDesignable extension UIBarButtonItem {
    @IBInspectable public var localizedTitleKey: String? {
        get {
            return nil // ignore
        }
        
        set {
            title = newValue?.localized
        }
    }
}

@IBDesignable extension UITabBarItem {
    @IBInspectable public var localizedTitleKey: String? {
        get {
            return nil // ignore
        }
        
        set {
            title = newValue?.localized
        }
    }
}

@IBDesignable extension UISearchBar {
    @IBInspectable public var localizedPlaceholderKey: String? {
        get {
            return nil // ignore
        }
        
        set {
            placeholder = newValue?.localized
        }
    }
}

@IBDesignable extension UIImageView {
    @IBInspectable public var localizedImageName: String? {
        get {
            return nil // ignore
        }
        
        set {
            self.imageName = newValue?.localized
        }
    }
}

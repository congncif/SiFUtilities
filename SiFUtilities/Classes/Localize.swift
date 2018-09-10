//
//  Common.swift
//  SiFUtilities
//
//  Created by FOLY on 2/4/17.
//  Copyright © 2017 [iF] Solution. All rights reserved.
//

import Foundation

public func LocalizedString(_ string: String, tableName: String? = nil) -> String {
    return NSLocalizedString(string, tableName: tableName, comment: string)
}

public protocol Localizable {
    var localized: String { get }
}

extension String: Localizable {
    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

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

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
    public var localizedTextKey: String? {
        get {
            return nil // ignore
        }

        set {
            text = newValue?.localized
        }
    }
}

@IBDesignable extension UITextField {
    public var localizedPlaceholderKey: String? {
        get {
            return nil // ignore
        }

        set {
            placeholder = newValue?.localized
        }
    }

    public var localizedTextKey: String? {
        get {
            return nil // ignore
        }

        set {
            text = newValue?.localized
        }
    }
}

@IBDesignable extension UITextView {
    public var localizedTextKey: String? {
        get {
            return nil // ignore
        }

        set {
            text = newValue?.localized
        }
    }
}

@IBDesignable extension UIButton {
    public var localizedNormalTitleKey: String? {
        get {
            return nil // ignore
        }

        set {
            setTitle(newValue?.localized, for: .normal)
        }
    }

    public var localizedSelectedTitleKey: String? {
        get {
            return nil // ignore
        }

        set {
            setTitle(newValue?.localized, for: .selected)
        }
    }
}

@IBDesignable extension UINavigationItem {
    public var localizedTitleKey: String? {
        get {
            return nil // ignore
        }

        set {
            title = newValue?.localized
        }
    }
}

@IBDesignable extension UIViewController {
    public var localizedTitleKey: String? {
        get {
            return nil // ignore
        }

        set {
            title = newValue?.localized
        }
    }
}

@IBDesignable extension UIBarButtonItem {
    public var localizedTitleKey: String? {
        get {
            return nil // ignore
        }

        set {
            title = newValue?.localized
        }
    }
}

@IBDesignable extension UITabBarItem {
    public var localizedTitleKey: String? {
        get {
            return nil // ignore
        }

        set {
            title = newValue?.localized
        }
    }
}

@IBDesignable extension UISearchBar {
    public var localizedPlaceholderKey: String? {
        get {
            return nil // ignore
        }

        set {
            placeholder = newValue?.localized
        }
    }
}

@IBDesignable extension UIImageView {
    public var localizedImageName: String? {
        get {
            return nil // ignore
        }

        set {
            self.imageName = newValue?.localized
        }
    }
}

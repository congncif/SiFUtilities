//
//  UITextField++.swift
//  Pods-SiFUtilities_Example
//
//  Created by FOLY on 4/6/18.
//

import Foundation

@IBDesignable
extension UITextField {
    @IBInspectable @objc open var leftPadding: CGFloat {
        get {
            return leftView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }

    @IBInspectable @objc open var rightPadding: CGFloat {
        get {
            return rightView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            rightView = paddingView
            rightViewMode = .always
        }
    }
}

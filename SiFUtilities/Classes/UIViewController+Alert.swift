//
//  UIViewController+Alert.swift
//  SiFUtilities
//
//  Created by FOLY on 2/4/17.
//  Copyright © 2017 [iF] Solution. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    open func confirm(title: String? = nil,
                      message: String?,
                      style: UIAlertControllerStyle = .alert,
                      dismissOthers: Bool = false,
                      cancelTitle: String = "Cancel".localized,
                      cancelHandler: (() -> Void)? = nil,
                      confirmedTitle: String = "OK".localized,
                      confirmedHandler: @escaping () -> Void) {
        if let presented = presentedViewController, let alert = presented as? UIAlertController {
            if dismissOthers {
                alert.dismiss(animated: false, completion: nil)
            } else {
                print("☞ Alert is presented on view controller \(self). Set up dismissOthers = true to hide current alert before present new alert")
                return
            }
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: { _ in
            cancelHandler?()
        }))
        alert.addAction(UIAlertAction(title: confirmedTitle, style: .default, handler: { _ in
            confirmedHandler()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    open func notify(title: String? = nil,
                     message: String?,
                     style: UIAlertControllerStyle = .alert,
                     dismissOthers: Bool = false,
                     buttonTitle: String = "OK".localized,
                     handler: (() -> Void)? = nil) {
        if let presented = presentedViewController, let alert = presented as? UIAlertController {
            if dismissOthers {
                alert.dismiss(animated: false, completion: nil)
            } else {
                print("☞ Alert is presented on view controller \(self). Set up dismissOthers = true to hide current alert before present new alert")
                return
            }
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        
        alert.addAction(UIAlertAction(title: buttonTitle, style: .cancel, handler: { _ in
            handler?()
        }))
        present(alert, animated: true, completion: nil)
    }
}

extension UIAlertController {
    open class func confirm(title: String? = nil,
                            message: String?,
                            style: UIAlertControllerStyle = .alert,
                            dismissOthers: Bool = false,
                            cancelTitle: String = "Cancel".localized,
                            cancelHandler: (() -> Void)? = nil,
                            confirmedTitle: String = "OK".localized,
                            confirmedHandler: @escaping () -> Void) {
        let viewController = UIApplication.topViewController()
        viewController?.confirm(title: title, message: message, style: style, dismissOthers: dismissOthers, cancelTitle: cancelTitle, cancelHandler: cancelHandler, confirmedTitle: confirmedTitle, confirmedHandler: confirmedHandler)
    }
    
    open class func notify(title: String? = nil,
                           message: String?,
                           style: UIAlertControllerStyle = .alert,
                           dismissOthers: Bool = false,
                           buttonTitle: String = "OK".localized,
                           handler: (() -> Void)? = nil) {
        let viewController = UIApplication.topViewController()
        viewController?.notify(title: title, message: message, style: style, dismissOthers: dismissOthers, buttonTitle: buttonTitle, handler: handler)
    }
}

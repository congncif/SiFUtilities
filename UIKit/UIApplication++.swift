//
//  UIApplication++.swift
//  SiFUtilities
//
//  Created by NGUYEN CHI CONG on 03/03/2023.
//

import Foundation
import UIKit

public extension UIApplication {
    var currentWindow: UIWindow? {
        let legacyWindow = keyWindow ?? windows.first(where: { $0.isKeyWindow }) ?? windows.last

        if #available(iOS 13.0, *) {
            let sceneWindow = connectedScenes
                .filter { $0.activationState == .foregroundActive }
                .compactMap { $0 as? UIWindowScene }
                .first?.windows
                .first(where: { $0.isKeyWindow })
            return sceneWindow ?? legacyWindow
        } else {
            return legacyWindow
        }
    }
}

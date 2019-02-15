//
//  AppDelegate.swift
//  SiFUtilities
//
//  Created by NGUYEN CHI CONG on 05/29/2016.
//  Copyright (c) 2016 NGUYEN CHI CONG. All rights reserved.
//

import SiFUtilities
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        let xxx = X()
        con(x: xxx.weakSelf)

        return true
    }

    class X: WeakReferenceProtocol {}

    func con(x: X.WeakSelf) {
        if let strongX = x() {
            print(strongX)
        }
    }
}

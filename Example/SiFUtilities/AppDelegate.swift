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
        let object = NSObject()
        window?.rootViewController?.attachObject(object)
        print("👉 \(object)")
        window?.rootViewController?.attachObject(object)

        let oid = ObjectIdentifier(object)
        let attObject: NSObject? = window?.rootViewController?.attachedObject(identifier: oid)
        print("👉 \(attObject)")

        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        if let rootVC = (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController {
            if let attObject: NSObject = rootVC.attachedObject() {
                print("👉 \(attObject)")
                rootVC.detachObject(attObject)
            }
        }
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        if let rootVC = (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController {
            if let attObject: NSObject = rootVC.attachedObject() {
                print("👉 \(attObject)")
            } else {
                print("👉 REMOVED")
            }
        }
    }
}

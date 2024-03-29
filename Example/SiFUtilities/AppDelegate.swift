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

    private let debouncer: Debouncer? = Debouncer(delay: .seconds(2)) { print("XX") }
    private var timerDebouncer: TimerDebouncer? = TimerDebouncer(delay: .seconds(2))

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            self.debouncer?.perform()
        }

        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            self.debouncer?.perform()
        }

        DispatchQueue.global().asyncAfter(deadline: .now() + 4.1) {
            self.debouncer?.perform()
        }

        timerDebouncer?.performNow()

        DispatchQueue.global().asyncAfter(deadline: .now() + 7) {
            self.timerDebouncer = nil
        }
        
        let dict = ["abc": "abc", "def": "def"]
        let newDict = dict.mapping(key: "abc", to: "ABC")
        print(newDict)

        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}
}

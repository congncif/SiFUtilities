//
//  Bundle++.swift
//  SiFUtilities
//
//  Created by NGUYEN CHI CONG on 2/15/19.
//

import Foundation

public extension Bundle {
    static var appVersion: String? {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }

    static var buildNumber: String? {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
    }
}

//
//  Extensions.swift
//  Pods
//
//  Created by FOLY on 5/29/16.
//
//

import Foundation

public func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

public func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}

extension URL {
    public var keyValueParameters: Dictionary<String, String>? {
        var results = [String:String]()
        let keyValues = self.query?.components(separatedBy: "&")
        if keyValues?.count > 0 {
            for pair in keyValues! {
                let kv = pair.components(separatedBy: "=")
                if kv.count > 1 {
                    results.updateValue(kv[1], forKey: kv[0])
                }
            }
        }
        return results
    }
}

// MARK: - Push
//////////////////////////////////////////////////////////////////////////////////////

public extension Data {
    public var deviceToken: String {
        let characterSet: CharacterSet = CharacterSet( charactersIn: "<>" )
        
        let deviceTokenString: String = ( self.description as NSString )
            .trimmingCharacters( in: characterSet )
            .replacingOccurrences( of: " ", with: "" ) as String
        
        return deviceTokenString
    }
}

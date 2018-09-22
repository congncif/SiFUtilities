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

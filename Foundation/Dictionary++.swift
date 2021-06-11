//
//  Dictionary++.swift
//  Pods
//
//  Created by FOLY on 9/13/17.
//
//

import Foundation

extension Dictionary {
    public mutating func map(key: Key, to newKey: Key, keepOldKey: Bool = false) {
        if let value = self[key] {
            updateValue(value, forKey: newKey)
            if !keepOldKey {
                removeValue(forKey: key)
            }
        }
    }

    public func mapping(key: Key, to newKey: Key, keepOldKey: Bool = false) -> Self {
        var newDict = self
        newDict.map(key: key, to: newKey)
        return newDict
    }
}

//
//  Enum++.swift
//  SiFUtilities
//
//  Created by FOLY on 3/26/18.
//

import Foundation

public protocol EnumCollection: Hashable {
    static var allValues: [Self] { get }
}

extension EnumCollection {
    public static func cases() -> AnySequence<Self> {
        typealias S = Self
        return AnySequence { () -> AnyIterator<S> in
            var raw = 0
            return AnyIterator {
                let current: Self = withUnsafePointer(to: &raw) { $0.withMemoryRebound(to: S.self, capacity: 1) { $0.pointee } }
                guard current.hashValue == raw else { return nil }
                raw += 1
                return current
            }
        }
    }
    
    public static var allValues: [Self] {
        return Array(cases())
    }
}

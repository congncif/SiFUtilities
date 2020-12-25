//
//  DefaultValueRepresentable.swift
//
//
//  Created by NGUYEN CHI CONG on 12/21/20.
//

import Foundation

public protocol DefaultValueRepresentable {
    static var `default`: Self { get }
}

extension Optional where Wrapped: DefaultValueRepresentable {
    public var `default`: Wrapped {
        switch self {
        case let .some(value):
            return value
        default:
            return Wrapped.default
        }
    }

    public func unwrapped(_ default: Wrapped = .default) -> Wrapped {
        return self ?? `default`
    }
}

extension String: DefaultValueRepresentable {
    public static var `default`: String { "" }
}

extension Array: DefaultValueRepresentable {
    public static var `default`: [Element] { [] }
}

extension Dictionary: DefaultValueRepresentable {
    public static var `default`: [Key: Value] { [:] }
}

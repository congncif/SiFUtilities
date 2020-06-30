//
//  NSObject++.swift
//
//
//  Created by FOLY on 4/7/18.
//

import Foundation

// MARK: - WeakReferenceProtocol

/**
 * Pass self as an argument might lead a retain cycle. To avoid this, pass weakSelf instead. To use `self`, just call a getter closure
 * Eg:  func someFunc(_ argv: () -> ObjectClass?) {
 *          let object = argv()
 *          ... // do something with object
 *      }
 */
public protocol WeakReferenceProtocol: AnyObject {
    associatedtype WeakReferenceType
    var weakSelfFactory: () -> WeakReferenceType? { get }
}

extension WeakReferenceProtocol {
    public typealias WeakSelfFactory = () -> Self?

    public var weakSelfFactory: WeakSelfFactory {
        return { [weak self] in self }
    }

    public var weakSelf: Self? {
        return weakSelfFactory()
    }
}

// MARK: - TypeNameProtocol

public protocol TypeNameProtocol {
    static var typeName: String { get }
    var typeName: String { get }
}

extension TypeNameProtocol {
    public static var typeName: String {
        return String(describing: self)
    }

    public var typeName: String {
        return String(describing: type(of: self))
    }
}

// MARK: - NSObjects extensions

extension NSObject: TypeNameProtocol {}

extension NSObject: WeakReferenceProtocol {}

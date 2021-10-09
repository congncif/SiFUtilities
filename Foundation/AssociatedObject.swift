//
//  AssociatedObject.swift
//  SiFUtilities
//
//  Created by FOLY on 1/26/17.
//  Copyright © 2017 [iF] Solution. All rights reserved.
//

import Foundation

public protocol AssociatedObject {
    func getAssociatedObject<T>(key: inout UInt8) -> T?
    func setAssociatedObject<T>(key: inout UInt8,
                                value: T?,
                                policy: objc_AssociationPolicy)
}

public extension AssociatedObject {
    func getAssociatedObject<T>(key: inout UInt8) -> T? {
        return objc_getAssociatedObject(self, &key) as? T
    }

    func setAssociatedObject<T>(key: inout UInt8,
                                value: T?,
                                policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC) {
        objc_setAssociatedObject(self, &key, value, policy)
    }
}

extension NSObject: AssociatedObject {}

//
//  Object++.swift
//  SiFUtilities
//
//  Created by FOLY on 9/22/18.
//

import Foundation

extension NSObject {
    public class var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last ?? String(describing: self)
    }

    public var className: String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last ?? String(describing: type(of: self))
    }
}

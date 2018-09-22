//
//  Object++.swift
//  SiFUtilities
//
//  Created by FOLY on 9/22/18.
//

import Foundation

extension NSObject {
    open class var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    open var className: String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }
}

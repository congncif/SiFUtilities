//
//  KeyValueProtocol.swift
//  SiFUtilities
//
//  Created by NGUYEN CHI CONG on 11/9/16.
//  Copyright © 2016 NGUYEN CHI CONG. All rights reserved.
//

import Foundation

public protocol KeyValueProtocol {
    var mapKeys: [String: String] {get}
}

extension KeyValueProtocol {
    public var mapKeys: [String: String] {
        return [:]
    }
    
    public func mapKey(key: String) -> String {
        var newKey = key
        if let mapKey = mapKeys[key] {
            newKey = mapKey
        }
        return newKey
    }
}

func unwrap(any:Any) -> Any? {
    let mi = Mirror(reflecting: any)
    if let style = mi.displayStyle {
        if style != .optional {
            return any
        }
        if mi.children.count == 0 { return nil }
        let (_, some) = mi.children.first!
        return some
    }
    return any
}

public extension KeyValueProtocol {
    public var dictionary: [String: Any] {
        var dict = [String: Any]()
        let otherSelf = Mirror(reflecting: self)
        
        for child in otherSelf.children {
            if let key = child.label {
                let newKey = mapKey(key: key)
                
                if let value = child.value as? KeyValueProtocol {
                    dict[newKey] = value.dictionary
                }
                else if let values = child.value as? [KeyValueProtocol] {
                    dict[newKey] = values.map({ (item) -> [String: Any] in
                        return item.dictionary
                    })
                }
                else {
                    dict[newKey] = unwrap(any: child.value)
                }
            }
        }
        
        var mirror: Mirror = otherSelf
        
        while let superMirror = mirror.superclassMirror {
            for child in superMirror.children {
                if let key = child.label {
                    
                    let newKey = mapKey(key: key)
                    
                    if let value = child.value as? KeyValueProtocol {
                        dict[newKey] = value.dictionary
                    }
                    else if let values = child.value as? [KeyValueProtocol] {
                        dict[newKey] = values.map({ (item) -> [String: Any] in
                            return item.dictionary
                        })
                    }
                    else {
                        dict[newKey] = unwrap(any: child.value)
                    }
                }
            }
            mirror = superMirror
        }
        
        return dict
    }
    
    public var JSONString: String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
            return String(data: jsonData, encoding: String.Encoding.utf8)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    public var keys: [String] {
        var results = [String]()
        let otherSelf = Mirror(reflecting: self)
        
        for child in otherSelf.children {
            if let key = child.label {
                let newKey = mapKey(key: key)
                results.append(newKey)
            }
        }
        
        var mirror: Mirror = otherSelf
        
        while let superMirror = mirror.superclassMirror {
            for child in superMirror.children {
                if let key = child.label {
                    let newKey = mapKey(key: key)
                    results.append(newKey)
                }
            }
            mirror = superMirror
        }
        
        return results
    }
}

open class KeyValueObject: NSObject, KeyValueProtocol {
    public init(dictionary: [String: Any]) {
        super.init()
        self.setValuesForKeys(dictionary)
    }
    
    public override init() {
        super.init()
    }
}

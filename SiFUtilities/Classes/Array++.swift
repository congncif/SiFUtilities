//
//  Array++.swift
//  Pods
//
//  Created by FOLY on 9/13/17.
//
//

import Foundation

extension Array where Element: Equatable {
    
    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
}
//MARK: - Sequence
//////////////////////////////////////////////////////////////////////////////////////

public extension Array {
    public mutating func shuffle() {
        for _ in 0..<self.count {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}

public extension Sequence {
    /// Categorises elements of self into a dictionary, with the keys given by keyFunc
    
    func categorise<U : Hashable>(_ keyFunc: (Iterator.Element) -> U) -> [U:[Iterator.Element]] {
        var dict: [U:[Iterator.Element]] = [:]
        for el in self {
            let key = keyFunc(el)
            if case nil = dict[key]?.append(el) { dict[key] = [el] }
        }
        return dict
    }
}

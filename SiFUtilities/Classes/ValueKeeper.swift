//
//  ValueKeeper.swift
//  Pods
//
//  Created by FOLY on 7/7/17.
//
//

import Foundation

open class ValueKeeper<Value> {
    private var value: Value?
    private var getValueAsync: ((@escaping (Value?) ->Void) -> Void)
    
    public init(defaultValue: Value? = nil, getValueAsync: @escaping ((@escaping (Value?) ->Void) -> Void)) {
        value = defaultValue
        self.getValueAsync = getValueAsync
    }
    
    open var syncValue: Value? {
        var val = value
        let semaphore = DispatchSemaphore(value: 0)
        
        DispatchQueue.global().async { [weak self] in
            guard let this = self else {
                semaphore.signal()
                return
            }
            this.getValueAsync({ newValue in
                val = newValue
                semaphore.signal()
            })
        }
        _ = semaphore.wait(timeout: .distantFuture)
        return val
    }
}

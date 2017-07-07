//
//  ValueKeeper.swift
//  Pods
//
//  Created by FOLY on 7/7/17.
//
//

import Foundation

public class ValueKeeper<Value> {
    private var value: Value?
    private var getValueAsync: ((@escaping (Value?) ->Void) -> Void)
    
    public init(defaultValue: Value? = nil, getValueAsync: @escaping ((@escaping (Value?) ->Void) -> Void)) {
        value = defaultValue
        self.getValueAsync = getValueAsync
    }
    
    public var syncValue: Value? {
        var val = value
        let semaphore = DispatchSemaphore(value: 0)
        getValueAsync({ newValue in
            val = newValue
            semaphore.signal()
        })
        _ = semaphore.wait(timeout: .distantFuture)
        return val
    }
    
}

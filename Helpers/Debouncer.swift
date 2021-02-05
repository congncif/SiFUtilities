//
//  Debouncer.swift
//
//
//  Created by NGUYEN CHI CONG on 3/2/17.
//  Copyright © 2017 [iF] Solution Co., Ltd. All rights reserved.
//

import Foundation

public final class TimerDebouncer {
    private var work: (() -> Void)?
    private var delay: TimeInterval
    
    private weak var timer: Timer?
    
    public init(delay: TimeInterval, work: (() -> Void)? = nil) {
        self.delay = delay
        self.work = work
    }
    
    deinit {
        cancel()
    }
    
    public func cancel() {
        timer?.invalidate()
        timer = nil
    }
    
    public func perform(work: (() -> Void)? = nil) {
        cancel()
        if let work = work {
            self.work = work
        }
        let nextTimer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(performNow), userInfo: nil, repeats: false)
        timer = nextTimer
    }
    
    @objc public func performNow() {
        guard let work = self.work else {
            #if DEBUG
            print("⚠️ [TimerDebouncer] Nothing to perform")
            #endif
            return
        }
        work()
    }
}

public final class Debouncer {
    private var delay: TimeInterval
    private let queue: DispatchQueue
    
    private var workItem: DispatchWorkItem?
    
    public init(queue: DispatchQueue = .main, delay: TimeInterval, work: (() -> Void)? = nil) {
        self.queue = queue
        self.delay = delay
        set(work: work)
    }
    
    private func set(work: (() -> Void)?) {
        if let work = work {
            workItem = DispatchWorkItem(block: work)
        }
    }
    
    deinit {
        cancel()
    }
    
    public func cancel() {
        workItem?.cancel()
    }
    
    public func perform(work: (() -> Void)? = nil) {
        cancel()
        set(work: work)
        guard let workItem = self.workItem else {
            #if DEBUG
            print("⚠️ [Debouncer] Nothing to perform")
            #endif
            return
        }
        queue.asyncAfter(deadline: .now() + delay, execute: workItem)
    }
    
    public func performNow() {
        guard let workItem = self.workItem else {
            #if DEBUG
            print("⚠️ [Debouncer] Nothing to perform")
            #endif
            return
        }
        queue.async(execute: workItem)
    }
}

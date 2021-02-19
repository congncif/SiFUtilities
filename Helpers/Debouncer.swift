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
    
    private var timer: DispatchSourceTimer?
    
    public init(delay: TimeInterval, work: (() -> Void)? = nil) {
        self.delay = delay
        set(work: work)
    }
    
    private func set(work: (() -> Void)?) {
        if let work = work {
            self.work = work
        }
    }
    
    deinit {
        timer?.setEventHandler(handler: nil)
        cancel()
    }
    
    public func cancel() {
        guard let timer = timer else { return }
        guard !timer.isCancelled else { return }
        timer.cancel()
    }
    
    public func perform(work: (() -> Void)? = nil) {
        cancel()
        set(work: work)
        
        guard let currentWork = self.work else {
            #if DEBUG
            print("⚠️ [TimerDebouncer] Nothing to perform")
            #endif
            return
        }
        
        let nextTimer = DispatchSource.makeTimerSource()
        nextTimer.schedule(deadline: .now() + delay)
        nextTimer.setEventHandler(handler: currentWork)
        timer = nextTimer
        timer?.resume()
    }
    
    public func performNow() {
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
    
    private var work: (() -> Void)?
    
    private var workItem: DispatchWorkItem?
    
    public init(queue: DispatchQueue = .main, delay: TimeInterval, work: (() -> Void)? = nil) {
        self.queue = queue
        self.delay = delay
        self.work = work
    }
    
    private func set(work: (() -> Void)?) {
        if let work = work {
            self.work = work
        }
    }
    
    private func newWorkItem() {
        if let work = self.work {
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
        newWorkItem()
        
        guard let workItem = self.workItem else {
            #if DEBUG
            print("⚠️ [Debouncer] Nothing to perform")
            #endif
            return
        }
        queue.asyncAfter(deadline: .now() + delay, execute: workItem)
    }
    
    public func performNow() {
        cancel()
        newWorkItem()
        
        guard let workItem = self.workItem else {
            #if DEBUG
            print("⚠️ [Debouncer] Nothing to perform")
            #endif
            return
        }
        queue.async(execute: workItem)
    }
}

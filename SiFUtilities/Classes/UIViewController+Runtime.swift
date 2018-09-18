//
//  UIExtensions.swift
//  PagingDataController
//
//  Created by FOLY on 5/28/16.
//  Copyright © 2016 FOLY. All rights reserved.
//

import Foundation

@IBDesignable extension UIViewController {

    // MARK: - Runtime properties
    
    fileprivate struct AssociatedKeys {
        static var LayoutDidFinished = false
        static var DidDisplay = false
    }
    
    public private(set) var layoutDidFinished: Bool {
        get {
            let number = objc_getAssociatedObject(self, &AssociatedKeys.LayoutDidFinished) as? NSNumber
            guard number != nil else { return false }
            return number!.boolValue
        }
        
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.LayoutDidFinished,
                NSNumber(value: newValue as Bool),
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    public private(set) var didDisplay: Bool {
        get {
            let number = objc_getAssociatedObject(self, &AssociatedKeys.DidDisplay) as? NSNumber
            guard number != nil else { return false }
            return number!.boolValue
        }
        
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.DidDisplay,
                NSNumber(value: newValue as Bool),
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }

    /*********************************************************************************/
    
    // MARK: -  Method Swizzling
    
    /*********************************************************************************/
    
    open class func swizzling() {
        struct Static {
            static var token = false
        }
        
        // make sure this isn't a subclass
        if self !== UIViewController.self {
            return
        }
        
        guard !Static.token else {
            return
        }
        Static.token = true
        
        let originalSelector = #selector(viewDidLayoutSubviews)
        let swizzledSelector = #selector(sif_viewDidLayoutSubviews)
        
        self.swizzledMethod(self, originalSelector: originalSelector, to: swizzledSelector)
        
        let originalSelector3 = #selector(viewWillAppear(_:))
        let swizzledSelector3 = #selector(sif_viewWillAppear(_:))
        
        self.swizzledMethod(self, originalSelector: originalSelector3, to: swizzledSelector3)
        
        let originalSelector4 = #selector(viewDidAppear(_:))
        let swizzledSelector4 = #selector(sif_viewDidAppear(_:))
        
        self.swizzledMethod(self, originalSelector: originalSelector4, to: swizzledSelector4)
    }
    
    open class func swizzledMethod(
        _ cls: AnyClass,
        originalSelector: Selector,
        to swizzledSelector: Selector
    ) {
        guard let originalMethod = class_getInstanceMethod(cls, originalSelector),
            let swizzledMethod = class_getInstanceMethod(cls, swizzledSelector) else {
            return
        }
        
        let didAddMethod = class_addMethod(
            cls,
            originalSelector,
            method_getImplementation(swizzledMethod),
            method_getTypeEncoding(swizzledMethod)
        )
        
        if didAddMethod {
            class_replaceMethod(
                cls,
                swizzledSelector,
                method_getImplementation(originalMethod),
                method_getTypeEncoding(originalMethod)
            )
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }

    @objc func sif_viewDidLayoutSubviews() {
        if self.layoutDidFinished == false {
            self.layoutDidFinished = true
            self.viewDidFinishLayout()
        }
    }
    
    @objc open func viewDidFinishLayout() {}
    @objc open func viewDidDisplay() {}
    
    @objc func sif_viewWillAppear(_ animated: Bool) {
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    @objc func sif_viewDidAppear(_ animated: Bool) {
        if self.didDisplay == false {
            self.didDisplay = true
            self.viewDidDisplay()
        }
    }
}

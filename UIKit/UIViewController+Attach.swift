//
//  UIViewController+Attach.swift
//  SiFUtilities
//
//  Created by NGUYEN CHI CONG on 1/13/21.
//

import Foundation
import UIKit

// MARK: - Attach object to UIViewController

final class WrappedController: UIViewController {
    let associatedObject: AnyObject

    init(associatedObject: AnyObject) {
        self.associatedObject = associatedObject
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public extension UIViewController {
    func attachObject(_ object: AnyObject) {
        let notAttached = children.allSatisfy {
            ($0 as? WrappedController)?.associatedObject !== object
        }

        guard notAttached else {
            #if DEBUG
            print("⚠️ \(object) was attached to \(self)!!!")
            #endif
            return
        }

        let controller = WrappedController(associatedObject: object)
        addChild(controller)
    }

    func attachedObject<Object: AnyObject>(identifier: ObjectIdentifier? = nil) -> Object? {
        children.compactMap {
            let object = ($0 as? WrappedController)?.associatedObject as? Object
            if let id = identifier, let existObject = object, ObjectIdentifier(existObject) == id {
                return existObject
            } else {
                return object
            }
        }.first
    }

    func attachedObjects<Object>() -> [Object] {
        children.compactMap {
            ($0 as? WrappedController)?.associatedObject as? Object
        }
    }

    func firstAttachedObject<Object>() -> Object? {
        attachedObjects().first
    }

    func lastAttachedObject<Object>() -> Object? {
        attachedObjects().last
    }

    func detachObject(_ object: AnyObject) {
        children.filter {
            ($0 as? WrappedController)?.associatedObject === object
        }.forEach {
            $0.removeFromParent()
        }
    }

    func detachObjects(where condition: (AnyObject) -> Bool) {
        children.filter {
            guard let associatedObject = ($0 as? WrappedController)?.associatedObject else { return false }
            return condition(associatedObject)
        }.forEach {
            $0.removeFromParent()
        }
    }

    func detachAllObjects() {
        children.filter { $0 is WrappedController }.forEach {
            $0.removeFromParent()
        }
    }
}

//
//  StoryboardSegue+Sender.swift
//
//
//  Created by NGUYEN CHI CONG on 9/15/19.
//

import Foundation
import UIKit

private var senderKey: UInt8 = 1

extension UIStoryboardSegue: AssociatedObject {
    public var sender: Any? {
        set {
            setAssociatedObject(key: &senderKey, value: newValue)
        }

        get {
            let value: Any? = getAssociatedObject(key: &senderKey)
            return value
        }
    }
}

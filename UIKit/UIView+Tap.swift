//
//  UIView+Tap.swift
//  DadMisc
//
//  Created by NGUYEN CHI CONG on 6/2/21.
//

import Foundation
import UIKit

private var tapHandlerKey: UInt = 1881

extension UIView {
    public func addTapGestureRecognizer(_ handler: @escaping () -> Void) {
        objc_setAssociatedObject(self, &tapHandlerKey, handler, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        let tapGestureReg = UITapGestureRecognizer(target: self, action: #selector(tapDetected(_:)))
        tapGestureReg.numberOfTouchesRequired = 1
        tapGestureReg.numberOfTapsRequired = 1
        addGestureRecognizer(tapGestureReg)
        isUserInteractionEnabled = true
    }

    @objc
    private func tapDetected(_ reg: UITapGestureRecognizer) {
        let handler = objc_getAssociatedObject(self, &tapHandlerKey) as? () -> Void
        tapAnimate {
            handler?()
        }
    }
}

public extension UIView {
    func tapAnimate(_ completionBlock: @escaping () -> Void) {
        isUserInteractionEnabled = false
        UIView.animate(
            withDuration: 0.1,
            delay: 0,
            options: .curveLinear,
            animations: { [weak self] in
                self?.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }
        ) { _ in
            UIView.animate(
                withDuration: 0.1,
                delay: 0,
                options: .curveLinear,
                animations: { [weak self] in
                    self?.transform = .identity
                }
            ) { [weak self] _ in
                self?.isUserInteractionEnabled = true
                completionBlock()
            }
        }
    }
}

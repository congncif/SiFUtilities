//
//  UIView++.swift
//  SiFUtilities
//
//  Created by NGUYEN CHI CONG on 3/4/21.
//

import Foundation
import UIKit

public extension UIView {
    func fillSubview(_ subview: UIView,
                     below topView: UIView? = nil,
                     back leftView: UIView? = nil,
                     above bottomView: UIView? = nil,
                     front rightView: UIView? = nil,
                     edgeInsets: UIEdgeInsets = .zero) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: leftView?.trailingAnchor ?? leadingAnchor, constant: edgeInsets.left),
            subview.trailingAnchor.constraint(equalTo: rightView?.leadingAnchor ?? trailingAnchor, constant: -edgeInsets.right),
            subview.topAnchor.constraint(equalTo: topView?.bottomAnchor ?? topAnchor, constant: edgeInsets.top),
            subview.bottomAnchor.constraint(equalTo: bottomView?.topAnchor ?? bottomAnchor, constant: -edgeInsets.bottom),
        ])
    }

    func fillSubview(_ subview: UIView,
                     below topAnchor: NSLayoutYAxisAnchor?,
                     back leadingAnchor: NSLayoutXAxisAnchor?,
                     above bottomAnchor: NSLayoutYAxisAnchor?,
                     front trailingAnchor: NSLayoutXAxisAnchor?,
                     edgeInsets: UIEdgeInsets = .zero) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: leadingAnchor ?? self.leadingAnchor, constant: edgeInsets.left),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor ?? self.trailingAnchor, constant: -edgeInsets.right),
            subview.topAnchor.constraint(equalTo: topAnchor ?? self.topAnchor, constant: edgeInsets.top),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor ?? self.bottomAnchor, constant: -edgeInsets.bottom),
        ])
    }
}

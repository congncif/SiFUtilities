//
//  UIView++.swift
//  SiFUtilities
//
//  Created by NGUYEN CHI CONG on 3/4/21.
//

import Foundation
import UIKit

public extension UIView {
    func fillSubView(_ subview: UIView, edgeInsets: UIEdgeInsets = .zero) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: edgeInsets.left),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -edgeInsets.right),
            subview.topAnchor.constraint(equalTo: topAnchor, constant: edgeInsets.top),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -edgeInsets.bottom),
        ])
    }
}

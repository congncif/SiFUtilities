//
//  UIColor+Extensions.swift
//  SiFUtilities
//
//  Created by Nguyen Chi Cong on 6/10/16.
//  Copyright © 2016 [iF] Solution. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UIColor

extension UIColor {
    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }

    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a/100)
    }

    open class func random(alpha: CGFloat = 1) -> UIColor {
        let randomRed = CGFloat(drand48())
        let randomGreen = CGFloat(drand48())
        let randomBlue = CGFloat(drand48())

        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: alpha)
    }
}

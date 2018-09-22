//
//  ColorButton.swift
//  SiFUtilities
//
//  Created by FOLY on 8/15/17.
//  Copyright © 2017 [iF] Solution. All rights reserved.
//

import UIKit

//MARK: - UIImage
extension UIImage {
    open class func image(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}

@IBDesignable open class TouchColorButton: UIButton {
    @IBInspectable open var color: UIColor = UIColor.white {
        didSet {
            setup()
        }
    }
    
    @IBInspectable open var touchedColor: UIColor? {
        didSet {
            self.setup()
        }
    }
    
    @IBInspectable open var circleBounds: Bool = false {
        didSet {
            setup()
        }
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setup()
    }
    
    open func setup() {
        let image = UIImage.image(color: color, size: bounds.size)
        setBackgroundImage(image, for: .normal)
        if let tColor = touchedColor {
            let touchedImage = UIImage.image(color: tColor, size: bounds.size)
            setBackgroundImage(touchedImage, for: .highlighted)
        }
        
        titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLabel?.textAlignment = NSTextAlignment.center
        
        if self.circleBounds {
            self.clipsToBounds = true
            self.cornerRadius = self.frame.size.height / 2
        }
    }
    
    open override func updateConstraints() {
        super.updateConstraints()
        
        if self.circleBounds {
            self.clipsToBounds = true
            self.cornerRadius = self.frame.size.height / 2
        }
    }
}

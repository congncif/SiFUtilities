//
//  SegmentItemBaseView.swift
//  SiFUtilities
//
//  Created by FOLY on 11/9/18.
//  Copyright © 2018 [iF] Solution. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol SegmentItemViewDelegate: class {
    func segmentItemViewDidSelect(_ item: SegmentItemBaseView)
}

// This implementation is just for Interface Builder

open class SegmentItemBaseView: UIView, SegmentItemProtocol {
    @IBOutlet public weak var delegate: SegmentItemViewDelegate?
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    func setup() {
        isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
        tapGesture.numberOfTapsRequired = 1
        addGestureRecognizer(tapGesture)
    }
    
    open var selected: Bool = false {
        didSet {
            render()
        }
    }
    
    @IBAction open func tapHandler() {
        delegate?.segmentItemViewDidSelect(self)
    }
    
    open func render() {}
}

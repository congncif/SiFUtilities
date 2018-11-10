//
//  Segment.swift
//  SiFUtilities
//
//  Created by FOLY on 11/9/18.
//  Copyright © 2018 [iF] Solution. All rights reserved.
//

import Foundation

@objc public protocol SegmentViewDelegate: class {
    func segmentViewDidChange(selectedIndex: Int)
}

// This implementation is just for Interface Builder

open class SegmentView: UIView, SegmentProtocol, SegmentItemViewDelegate {
    @IBOutlet public var items: [SegmentItemBaseView] = []
    
    @IBOutlet public weak var delegate: SegmentViewDelegate?
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        for itemView in items {
            if itemView.delegate == nil {
                itemView.delegate = self
            }
        }
        
        if items.count > 0 {
            selectItem(at: 0)
        }
    }
    
    open func segmentItemViewDidSelect(_ item: SegmentItemBaseView) {
        selectItem(item)
        
        if let index = selectedIndex {
            delegate?.segmentViewDidChange(selectedIndex: index)
        }
    }
}

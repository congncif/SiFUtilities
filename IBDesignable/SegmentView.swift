//
//  Segment.swift
//  SiFUtilities
//
//  Created by FOLY on 11/9/18.
//  Copyright © 2018 [iF] Solution. All rights reserved.
//

import Foundation
import UIKit

public protocol SegmentItemProtocol: AnyObject {
    var selected: Bool { get set }
}

public protocol SegmentProtocol: AnyObject {
    associatedtype Item: SegmentItemProtocol
    var items: [Item] { get set }
}

public extension SegmentProtocol {
    func selectItem(at index: Int) {
        guard index >= 0, index < items.count else { return }
        
        let selectedItems = items.filter { $0.selected == true }
        
        selectedItems.forEach { object in
            object.selected = false
        }
        
        let item = items[index]
        item.selected = true
    }
    
    var selectedIndex: Int? {
        return items.lastIndex { $0.selected }
    }
    
    func resetSelections() {
        let selectedItems = items.filter { $0.selected == true }
        selectedItems.forEach { object in
            object.selected = false
        }
    }
}

public extension SegmentProtocol where Item: Equatable {
    func selectItem(_ item: Item) {
        if let idx = items.lastIndex(where: { $0 == item }) {
            selectItem(at: idx)
        }
    }
}

@objc public protocol SegmentItemViewDelegate: AnyObject {
    func segmentItemViewDidSelect(_ item: SegmentItemBaseView)
}

// This implementation is just for Interface Builder

open class SegmentItemBaseView: UIView, SegmentItemProtocol {
    @IBOutlet public weak var delegate: SegmentItemViewDelegate?
    
    override open func awakeFromNib() {
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

@objc public protocol SegmentViewDelegate: AnyObject {
    func segmentViewDidChange(selectedIndex: Int)
    func segmentViewDidReset()
}

// This implementation is just for Interface Builder

open class SegmentView: UIView, SegmentProtocol, SegmentItemViewDelegate {
    @IBOutlet public var items: [SegmentItemBaseView] = []
    
    @IBOutlet public weak var delegate: SegmentViewDelegate?
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        for itemView in items {
            if itemView.delegate == nil {
                itemView.delegate = self
            }
        }
        
        if !items.isEmpty {
            selectItem(at: 0)
        }
    }
    
    open func segmentItemViewDidSelect(_ item: SegmentItemBaseView) {
        selectItem(item)
        
        if let index = selectedIndex {
            delegate?.segmentViewDidChange(selectedIndex: index)
        }
    }
    
    open func reset() {
        resetSelections()
        delegate?.segmentViewDidReset()
    }
}

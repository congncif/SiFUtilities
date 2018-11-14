//
//  SegmentProtocol.swift
//  SiFUtilities
//
//  Created by FOLY on 11/9/18.
//  Copyright © 2018 [iF] Solution. All rights reserved.
//

import Foundation

public protocol SegmentProtocol: class {
    associatedtype Item: SegmentItemProtocol
    var items: [Item] { get set }
}

extension SegmentProtocol {
    public func selectItem(at index: Int) {
        guard index >= 0 && index < items.count else { return }

        let selectedItems = items.filter { $0.selected == true }

        selectedItems.forEach { object in
            object.selected = false
        }

        let item = items[index]
        item.selected = true
    }

    public var selectedIndex: Int? {
        return items.lastIndex { $0.selected }
    }
    
    public func resetSelections() {
        let selectedItems = items.filter { $0.selected == true }
        selectedItems.forEach { object in
            object.selected = false
        }
    }
}

extension SegmentProtocol where Item: Equatable {
    public func selectItem(_ item: Item) {
        if let idx = items.lastIndex(where: { $0 == item }) {
            selectItem(at: idx)
        }
    }
}

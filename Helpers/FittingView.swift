//
//  FittingView.swift
//  SiFUtilities
//
//  Created by NGUYEN CHI CONG on 8/8/18.
//  Copyright © 2019 NGUYEN CHI CONG. All rights reserved.
//

import CoreGraphics
import Foundation
import UIKit

public enum FittingContentHeight: Equatable {
    case autoSizing
    case explicit(CGFloat)

    public static func == (lhs: FittingContentHeight, rhs: FittingContentHeight) -> Bool {
        switch (lhs, rhs) {
        case (.autoSizing, .autoSizing):
            return true
        case let (.explicit(lhsHeight), .explicit(rhsHeight)):
            return lhsHeight == rhsHeight
        default:
            return false
        }
    }
}

protocol ContentFitting: UIView {
    var fittingHeight: FittingContentHeight { get set }
}

extension ContentFitting {
    func adjustContentHeight(_ contentHeight: FittingContentHeight) {
        guard contentHeight != fittingHeight else { return }
        fittingHeight = contentHeight

        invalidateIntrinsicContentSize()
        layoutIfNeeded()

        DispatchQueue.main.async {
            self.closestContainerTableView?.performUpdates()
        }
    }
}

// MARK: - FittingView

open class FittingView: UIView, ContentFitting {
    var fittingHeight: FittingContentHeight = .autoSizing

    override open var intrinsicContentSize: CGSize {
        switch fittingHeight {
        case .autoSizing:
            return super.intrinsicContentSize
        case let .explicit(height):
            return CGSize(width: bounds.size.width, height: height)
        }
    }

    public func updateHeight(_ contentHeight: FittingContentHeight) {
        adjustContentHeight(contentHeight)
    }
}

// MARK: - FittingTableView

open class FittingTableView: UITableView, ContentFitting {
    private var observation: NSKeyValueObservation?

    var fittingHeight: FittingContentHeight = .autoSizing

    func registerContentSizeObserver() {
        observation = contentSizeObservation
    }

    override public init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        registerContentSizeObserver()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        registerContentSizeObserver()
    }

    deinit {
        if #available(iOS 11.0, *) {
            observation?.invalidate()
            observation = nil
        } else if let observer = observation {
            removeObserver(observer, forKeyPath: "contentSize")
        }
    }

    override open var intrinsicContentSize: CGSize {
        switch fittingHeight {
        case .autoSizing:
            return contentSize
        case let .explicit(height):
            return CGSize(width: bounds.size.width, height: height)
        }
    }

    public func updateHeight(_ contentHeight: FittingContentHeight) {
        adjustContentHeight(contentHeight)
    }
}

// MARK: - FittingCollectionView

open class FittingCollectionView: UICollectionView, ContentFitting {
    private var observation: NSKeyValueObservation?

    var fittingHeight: FittingContentHeight = .autoSizing

    func registerContentSizeObserver() {
        observation = contentSizeObservation
    }

    override public init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        registerContentSizeObserver()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        registerContentSizeObserver()
    }

    deinit {
        if #available(iOS 11.0, *) {
            observation?.invalidate()
            observation = nil
        } else if let observer = observation {
            removeObserver(observer, forKeyPath: "contentSize")
        }
    }

    override open var intrinsicContentSize: CGSize {
        switch fittingHeight {
        case .autoSizing:
            return contentSize
        case let .explicit(height):
            return CGSize(width: bounds.size.width, height: height)
        }
    }

    public func updateHeight(_ contentHeight: FittingContentHeight) {
        adjustContentHeight(contentHeight)
    }
}

// MARK: - FittingScrollView

open class FittingScrollView: UIScrollView, ContentFitting {
    private var observation: NSKeyValueObservation?

    var fittingHeight: FittingContentHeight = .autoSizing

    func registerContentSizeObserver() {
        observation = contentSizeObservation
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        registerContentSizeObserver()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        registerContentSizeObserver()
    }

    deinit {
        if #available(iOS 11.0, *) {
            observation?.invalidate()
            observation = nil
        } else if let observer = observation {
            removeObserver(observer, forKeyPath: "contentSize")
        }
    }

    override open var intrinsicContentSize: CGSize {
        switch fittingHeight {
        case .autoSizing:
            return contentSize
        case let .explicit(height):
            return CGSize(width: bounds.size.width, height: height)
        }
    }

    public func updateHeight(_ contentHeight: FittingContentHeight) {
        adjustContentHeight(contentHeight)
    }
}

// MARK: - Extensions

extension UIScrollView {
    var contentSizeObservation: NSKeyValueObservation {
        observe(\.contentSize, options: [.old, .new]) { object, change in
            let oldValue = change.oldValue
            let newValue = change.newValue

            if oldValue?.height != newValue?.height {
                object.invalidateIntrinsicContentSize()
                object.closestContainerTableView?.performUpdates()
            }
        }
    }
}

extension UIView {
    public var closestContainerTableView: UITableView? {
        if let tableView = superview as? UITableView {
            return tableView
        } else {
            return superview?.closestContainerTableView
        }
    }
}

private var animationKey: UInt8 = 1

extension UITableView {
    open var resizingAnimationEnabled: Bool {
        set {
            objc_setAssociatedObject(self, &animationKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }

        get {
            objc_getAssociatedObject(self, &animationKey) as? Bool ?? true
        }
    }

    public func performUpdates(_ updates: (() -> Void)? = nil) {
        if resizingAnimationEnabled {
            beginUpdates()
            updates?()
            endUpdates()
        } else {
            UIView.performWithoutAnimation {
                beginUpdates()
                updates?()
                endUpdates()
            }
        }
    }
}

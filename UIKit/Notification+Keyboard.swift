//
//  Notification+Keyboard.swift
//  SiFUtilities
//
//  Created by NGUYEN CHI CONG on 5/12/21.
//

import Foundation
import UIKit

public extension Notification {
    var keyboardFrame: CGRect? {
        userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
    }

    var keyboardHeight: CGFloat? {
        keyboardFrame?.height
    }

    var keyboardAnimationDuration: CGFloat? {
        userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? CGFloat
    }
}

public struct KeyboardInfo {
    public let visible: Bool
    public let height: CGFloat
    public let diff: CGFloat
    public let animationDuration: TimeInterval
}

public final class KeyboardAppearanceObserver {
    private let handler: (KeyboardInfo) -> Void

    public init(handler: @escaping (_ info: KeyboardInfo) -> Void) {
        self.handler = handler
    }

    public func startObserving() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification, object: nil, queue: OperationQueue.main, using: { [weak self] notification in
            self?.didChange(notification)
        })
    }

    public func stopObserving() {
        NotificationCenter.default.removeObserver(self)
    }

    deinit {
        stopObserving()
    }

    func didChange(_ notification: Notification) {
        var isKeyBoardShowing = false

        let isPortrait = UIApplication.shared.statusBarOrientation.isPortrait
        // get the keyboard & window frames

        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
        // keyboardHeightDiff used when user is switching between different keyboards that have different heights
        var keyboardFrameBegin = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect ?? .zero

        // hack for bug in iOS 11.2
        let keyboardFrameEnd = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
        if keyboardFrameEnd.size.height > keyboardFrameBegin.size.height {
            keyboardFrameBegin = CGRect(x: keyboardFrameBegin.origin.x, y: keyboardFrameBegin.origin.y, width: keyboardFrameBegin.size.width, height: keyboardFrameEnd.size.height)
        }

        var keyboardHeightDiff: CGFloat = 0.0
        if keyboardFrameBegin.size.height > 0 {
            keyboardHeightDiff = keyboardFrameBegin.size.height - keyboardFrame.size.height
        }
        let screenSize = UIScreen.main.bounds.size
//        let animationCurve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int ?? 0
//        let animationOptions = animationCurve << 16
        // if split keyboard is being dragged, then skip notification

        if keyboardFrame.size.height == 0, UIDevice.current.userInterfaceIdiom == .pad {
            if isPortrait, keyboardFrameBegin.origin.y + keyboardFrameBegin.size.height == screenSize.height {
                return
            } else if !isPortrait, keyboardFrameBegin.origin.x + keyboardFrameBegin.size.width == screenSize.width {
                return
            }
        }
        // calculate if we are to move up the avoiding view
        if !keyboardFrame.isEmpty, keyboardFrame.origin.y == 0 || (keyboardFrame.origin.y + keyboardFrame.size.height == screenSize.height) {
            isKeyBoardShowing = true
        }

        // get animation duration
        var animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0
        if animationDuration == 0 {
            // custom keyboards often don't animate, its too clanky so have to manually set this
            animationDuration = 0.1
        }

        let info = KeyboardInfo(visible: isKeyBoardShowing, height: keyboardFrame.height, diff: keyboardHeightDiff, animationDuration: animationDuration)
        handler(info)
    }
}

public final class KeyboardAppearanceScrollObserver {
    private weak var scrollView: UIScrollView?

    private var initialContentInset: UIEdgeInsets?

    public init(scrollView: UIScrollView) {
        self.scrollView = scrollView
    }

    private lazy var observer = KeyboardAppearanceObserver { [weak self] info in
        if self?.initialContentInset == nil {
            self?.initialContentInset = self?.scrollView?.contentInset
        }

        guard let scrollView = self?.scrollView, let initialContentInset = self?.initialContentInset else { return }
        var contentInset = initialContentInset
        contentInset.bottom = initialContentInset.bottom + (info.visible ? info.height : 0)
        scrollView.contentInset = contentInset

        if let activeView = scrollView.firstResponder, info.visible {
            let rect = activeView.convert(activeView.bounds, to: scrollView)
            let bounds = UIScreen.main.bounds

            let activeViewMaxY = rect.maxY + scrollView.frame.minY + scrollView.contentInset.top - scrollView.contentOffset.y
            let visibleMaxY = bounds.height - info.height

            let missingDistance = activeViewMaxY - visibleMaxY

            if missingDistance > 0 {
                var contentOffset = scrollView.contentOffset
                contentOffset.y = scrollView.contentOffset.y + missingDistance + 20

                scrollView.contentOffset = contentOffset
            }
        }
    }

    public func startObserving() {
        observer.startObserving()
    }

    public func stopObserving() {
        observer.stopObserving()
    }
}

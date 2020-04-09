//
//  UIViewController+Show.swift
//  Pods
//
//  Created by FOLY on 7/14/17.
//
//

import Foundation
import UIKit

public struct PresentConfiguration {
    public let navigationType: UINavigationController.Type?
    public let modalPresentationStyle: UIModalPresentationStyle
    public let modalTransitionStyle: UIModalTransitionStyle
    public let isModalInPresentation: Bool

    public init(navigationType: UINavigationController.Type?,
                modalPresentationStyle: UIModalPresentationStyle,
                modalTransitionStyle: UIModalTransitionStyle,
                isModalInPresentation: Bool) {
        self.navigationType = navigationType
        self.modalPresentationStyle = modalPresentationStyle
        self.modalTransitionStyle = modalTransitionStyle
        self.isModalInPresentation = isModalInPresentation
    }

    public static var embeddedInNavigation: PresentConfiguration {
        if #available(iOS 13.0, *) {
            return PresentConfiguration(navigationType: UINavigationController.self, modalPresentationStyle: .automatic, modalTransitionStyle: .coverVertical, isModalInPresentation: true)
        } else {
            return PresentConfiguration(navigationType: UINavigationController.self, modalPresentationStyle: .fullScreen, modalTransitionStyle: .coverVertical, isModalInPresentation: true)
        }
    }

    public static var `default`: PresentConfiguration {
        if #available(iOS 13.0, *) {
            return PresentConfiguration(navigationType: nil, modalPresentationStyle: .automatic, modalTransitionStyle: .coverVertical, isModalInPresentation: true)
        } else {
            return PresentConfiguration(navigationType: nil, modalPresentationStyle: .fullScreen, modalTransitionStyle: .coverVertical, isModalInPresentation: true)
        }
    }
}

public enum PresentationStyle {
    case push
    case present(PresentConfiguration)

    public static var defaultPresent: PresentationStyle {
        return .present(.embeddedInNavigation)
    }
}

public enum PresentationCloseStyle {
    case `default`
    case close
    case auto
}

public final class PresentationConfiguration {
    public var style: PresentationStyle? // default is nil, auto detect presentation style
    public var animated: Bool = true
    public var backTitle: String = ""
    public var hidesBottomBarWhenPushed: Bool = true

    private init() {}

    public static var `default`: PresentationConfiguration { PresentationConfiguration() }

    public func apply(_ configurationBlock: (PresentationConfiguration) -> Void = { _ in }) -> PresentationConfiguration {
        configurationBlock(self)
        return self
    }
}

extension UIViewController {
    public func show(_ viewController: UIViewController,
                     configurationBlock: (PresentationConfiguration) -> Void = { _ in },
                     completion: (() -> Void)? = nil) {
        let configs = PresentationConfiguration.default.apply(configurationBlock)
        show(viewController, configuration: configs, completion: completion)
    }

    public func show(_ viewController: UIViewController,
                     configuration: PresentationConfiguration = .default,
                     completion: (() -> Void)? = nil) {
        viewController.hidesBottomBarWhenPushed = configuration.hidesBottomBarWhenPushed
        viewController.setNavigationBarBackTitle(configuration.backTitle)

        let source: UIViewController = self
        var destination: UIViewController

        let targetIsNavigation = viewController is UINavigationController
        let sourceIsNavigation = self is UINavigationController

        var presentationStyle: PresentationStyle
        if let style = configuration.style {
            presentationStyle = style
        } else {
            if targetIsNavigation {
                presentationStyle = .present(.default)
            } else if sourceIsNavigation {
                presentationStyle = .push
            } else if navigationController != nil {
                presentationStyle = .push
            } else {
                presentationStyle = .present(.embeddedInNavigation)
            }
        }

        switch presentationStyle {
        case .push:
            destination = viewController
            source.navigator?.pushViewController(destination, animated: configuration.animated)
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.25, execute: completion)
            }
        case .present(let configs):
            if let navigationType = configs.navigationType {
                if let nav = viewController as? UINavigationController {
                    nav.topViewController?.showCloseButton(at: .left)
                    destination = nav
                } else {
                    viewController.showCloseButton(at: .left)
                    destination = navigationType.init(rootViewController: viewController)
                }
            } else {
                if let nav = viewController as? UINavigationController {
                    nav.topViewController?.showCloseButton(at: .left)
                }
                destination = viewController
            }
            destination.modalPresentationStyle = configs.modalPresentationStyle
            destination.modalTransitionStyle = configs.modalTransitionStyle
            if #available(iOS 13.0, *) {
                destination.isModalInPresentation = configs.isModalInPresentation
            } else {
                // Fallback on earlier versions
            }
            source.present(destination, animated: configuration.animated, completion: completion)
        }
    }

    private var navigator: UINavigationController? {
        if let nav = self as? UINavigationController {
            return nav
        } else {
            return navigationController
        }
    }
}

extension UIViewController {
    @available(*, deprecated, message: "This method was replaced by method show(_:configuration:completion)")
    public func show(on baseViewController: UIViewController,
                     embedIn NavigationType: UINavigationController.Type = UINavigationController.self,
                     closeButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop),
                     position: CloseButtonPosition = .left,
                     animated: Bool = true,
                     completion: (() -> Void)? = nil) {
        if let navigation = baseViewController as? UINavigationController {
            navigation.pushViewController(self, animated: animated)
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.25, execute: completion)
            }
        } else {
            baseViewController.present(self, embedIn: NavigationType, closeButton: closeButton, position: position, animated: animated, completion: completion)
        }
    }

    @available(*, deprecated, message: "This method was replaced by method show(_:configuration:completion)")
    public func show(viewController: UIViewController,
                     from baseviewController: UIViewController? = nil,
                     embedIn NavigationType: UINavigationController.Type = UINavigationController.self,
                     closeButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop),
                     position: CloseButtonPosition = .left,
                     animated: Bool = true,
                     completion: (() -> Void)? = nil) {
        guard let base = baseviewController else {
            if let navigation = self.navigationController {
                viewController.show(on: navigation, embedIn: NavigationType, closeButton: closeButton, position: position, animated: animated, completion: completion)
            } else {
                viewController.show(on: self, embedIn: NavigationType, closeButton: closeButton, position: position, animated: animated, completion: completion)
            }
            return
        }
        viewController.show(on: base, embedIn: NavigationType, closeButton: closeButton, position: position, animated: animated, completion: completion)
    }

    @available(*, deprecated, message: "This method was replaced by method show(_:configuration:completion)")
    public func present(_ vc: UIViewController, embedIn navigationType: UINavigationController.Type = UINavigationController.self, closeButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop), position: CloseButtonPosition = .left, animated: Bool = true, completion: (() -> Void)? = nil) {
        if let nav = vc as? UINavigationController {
            nav.topViewController?.showCloseButton(closeButton, at: position)
            present(nav, animated: animated, completion: completion)
        } else {
            vc.showCloseButton(at: position)
            let nav = navigationType.init(rootViewController: vc)
            present(nav, animated: animated, completion: completion)
        }
    }

    public func backToPrevious(animated: Bool = true, completion: (() -> Void)? = nil) {
        if let navigation = self.navigationController {
            if navigation.viewControllers.first != self {
                navigation.popViewController(animated: animated)
                if let completion = completion {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.25, execute: completion)
                }
            } else {
                if let _ = navigation.presentingViewController {
                    navigation.dismiss(animated: animated, completion: completion)
                } else {
                    assertionFailure("Previous page not found")
                }
            }
        } else if let _ = self.presentingViewController {
            dismiss(animated: animated, completion: completion)
        } else {
            assertionFailure("Previous page not found")
        }
    }

    public func forceDismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
        if let presenting = self.presentingViewController {
            presenting.dismiss(animated: animated, completion: completion)
        } else if let navigation = navigationController, let presenting = navigation.presentingViewController {
            presenting.dismiss(animated: animated, completion: completion)
        } else if let presented = self.presentedViewController {
            presented.dismiss(animated: animated, completion: completion)
        } else {
            dismiss(animated: animated, completion: completion)
        }
    }
}

extension UIViewController {
    public enum CloseButtonPosition {
        case left
        case right
    }

    public func showCloseButton(_ barButtonItem: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop), at position: CloseButtonPosition = .left) {
        barButtonItem.action = #selector(dismissButtonDidTap(_:))
        barButtonItem.target = self

        switch position {
        case .left:
            navigationItem.leftBarButtonItem = barButtonItem
        case .right:
            navigationItem.rightBarButtonItem = barButtonItem
        }
    }

    public func showCloseButtonIfNeeded(_ barButtonItem: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop), at position: CloseButtonPosition = .left) {
        if isPresentedInNavigation, isRootOfNavigation {
            showCloseButton(barButtonItem, at: position)
        }
    }

    @IBAction private func dismissButtonDidTap(_ sender: Any) {
        forceDismiss()
    }

    var isRootOfNavigation: Bool {
        return navigationController?.viewControllers.first == self
    }

    var isPresentedInNavigation: Bool {
        return navigationController?.presentingViewController != nil
    }
}

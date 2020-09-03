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
    public let isModalInPresentation: Bool // iOS 13 only

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

    public static var embeddedInNavigationFullScreen: PresentConfiguration {
        PresentConfiguration(navigationType: UINavigationController.self, modalPresentationStyle: .fullScreen, modalTransitionStyle: .coverVertical, isModalInPresentation: true)
    }

    public static var `default`: PresentConfiguration {
        if #available(iOS 13.0, *) {
            return PresentConfiguration(navigationType: nil, modalPresentationStyle: .automatic, modalTransitionStyle: .coverVertical, isModalInPresentation: true)
        } else {
            return PresentConfiguration(navigationType: nil, modalPresentationStyle: .fullScreen, modalTransitionStyle: .coverVertical, isModalInPresentation: true)
        }
    }

    public static var defaultFullScreen: PresentConfiguration {
        return PresentConfiguration(navigationType: nil, modalPresentationStyle: .fullScreen, modalTransitionStyle: .coverVertical, isModalInPresentation: true)
    }
}

public enum NavigateConfiguration {
    case push
    case replace
    case replaceAll
}

public enum PresentationStyle {
    case navigate(NavigateConfiguration)
    case present(PresentConfiguration)

    public static var defaultPresent: PresentationStyle {
        return .present(.embeddedInNavigation)
    }
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
                     configurations: (PresentationConfiguration) -> Void,
                     completion: (() -> Void)? = nil) {
        let configs = PresentationConfiguration.default.apply(configurations)
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
                presentationStyle = .present(.defaultFullScreen)
            } else if sourceIsNavigation {
                presentationStyle = .navigate(.push)
            } else if navigationController != nil {
                presentationStyle = .navigate(.push)
            } else {
                presentationStyle = .present(.embeddedInNavigationFullScreen)
            }
        }

        switch presentationStyle {
        case let .navigate(configs):
            switch configs {
            case .push:
                destination = viewController
                source.navigator?.pushViewController(destination, animated: configuration.animated)
            case .replace:
                destination = viewController
                let viewControllers = source.navigator?.viewControllers ?? []
                let droppedViewControllers = Array(viewControllers.dropLast())
                if droppedViewControllers.isEmpty {
                    destination.showCloseButton(at: .left)
                }
                let newViewControllers = droppedViewControllers + [destination]
                source.navigator?.setViewControllers(newViewControllers, animated: configuration.animated)
            case .replaceAll:
                destination = viewController
                destination.showCloseButton(at: .left)
                source.navigator?.setViewControllers([destination], animated: configuration.animated)
            }
            if let completion = completion, configuration.animated {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.25, execute: completion)
            } else {
                completion?()
            }

        case let .present(configs):
            if let navigationType = configs.navigationType {
                if let nav = viewController as? UINavigationController {
                    nav.viewControllers.first?.showCloseButton(at: .left)
                    destination = nav
                } else {
                    viewController.showCloseButton(at: .left)
                    destination = navigationType.init(rootViewController: viewController)
                }
            } else {
                if let nav = viewController as? UINavigationController {
                    nav.viewControllers.first?.showCloseButton(at: .left)
                }
                destination = viewController
            }
            destination.modalPresentationStyle = configs.modalPresentationStyle
            destination.modalTransitionStyle = configs.modalTransitionStyle
            if #available(iOS 13.0, *) {
                destination.isModalInPresentation = configs.isModalInPresentation
            }
            source.topPresentedViewController.present(destination, animated: configuration.animated, completion: completion)
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
    public func backToPrevious(animated: Bool = true, completion: (() -> Void)? = nil) {
        if let navigation = navigationController {
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
        } else if let _ = presentingViewController {
            dismiss(animated: animated, completion: completion)
        } else {
            assertionFailure("Previous page not found")
        }
    }

    public func forceDismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
        if let presenting = presentingViewController {
            presenting.dismiss(animated: animated, completion: completion)
        } else if let navigation = navigationController, let presenting = navigation.presentingViewController {
            presenting.dismiss(animated: animated, completion: completion)
        } else if let presented = presentedViewController {
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

    @objc private func dismissButtonDidTap(_ sender: Any) {
        forceDismiss()
    }

    public var isRootOfNavigation: Bool {
        return navigationController?.viewControllers.first == self
    }

    public var isPresentedInNavigation: Bool {
        return navigationController?.presentingViewController != nil
    }
}

// MARK: - Segues + Show

public final class ShowSegue: UIStoryboardSegue {
    override public func perform() {
        let animated = UIView.areAnimationsEnabled
        source.show(destination, configurations: { $0.animated = animated })
    }
}

// MARK: - Deprecated

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
            if let navigation = navigationController {
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
}

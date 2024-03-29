//
//  UIViewController+PushOver.swift
//  SiFUtilities
//
//  Created by NGUYEN CHI CONG on 8/18/20.
//

import Foundation
import UIKit

public extension UIViewController {
    func pushOverFullScreen(_ viewController: UIViewController,
                            navigationType: UINavigationController.Type? = nil,
                            animated: Bool = true) {
        let contentView = topMostViewController.oldestLineageViewController.view.snapshotView(afterScreenUpdates: true)
        let rootViewController = ResumeDismissViewController(contentView: contentView)
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.view.backgroundColor = .clear

        let configuration = PresentationConfiguration.default.apply {
            $0.style = .present(PresentConfiguration(navigationType: navigationType, modalPresentationStyle: .fullScreen, modalTransitionStyle: .crossDissolve, isModalInPresentation: false))
            $0.animated = false
        }

        topMostViewController.show(navigationController, configuration: configuration) {
            navigationController.pushViewController(viewController, animated: animated)
        }
    }

    func popOverFullScreen(animated: Bool = true, completion: (() -> Void)? = nil) {
        let presentedNavigation = presentedViewController as? UINavigationController

        guard let foundNavigation = presentedNavigation ?? navigationController ?? self as? UINavigationController, let rootViewController = foundNavigation.rootViewController as? ResumeDismissViewController else {
            assertionFailure("Cannot detect Over Full Screen")
            return
        }

        rootViewController.dismissHandler = completion
        foundNavigation.popToRootViewController(animated: animated)
    }
}

// MARK: - Segues

public final class PushOverFullScreenSegue: UIStoryboardSegue {
    override public func perform() {
        let animated = UIView.areAnimationsEnabled
        source.pushOverFullScreen(destination, animated: animated)
    }
}

public final class UnwindPopOverFullScreenSegue: UIStoryboardSegue {
    override public func perform() {
        let animated = UIView.areAnimationsEnabled
        destination.popOverFullScreen(animated: animated)
    }
}

// MARK: - Internal ResumeDismissViewController

final class ResumeDismissViewController: UIViewController {
    private var appearCount: Int = 0

    private let contentView: UIView

    var dismissHandler: (() -> Void)?

    init(contentView: UIView?) {
        self.contentView = contentView ?? UIView()
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let backItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem

        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard appearCount == 0 else {
            dismiss(animated: false, completion: dismissHandler)
            return
        }
        appearCount += 1
    }
}

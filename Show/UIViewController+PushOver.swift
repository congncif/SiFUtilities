//
//  UIViewController+PushOver.swift
//  SiFUtilities
//
//  Created by NGUYEN CHI CONG on 8/18/20.
//

import Foundation
import UIKit

extension UIViewController {
    public func pushOverFullScreen(_ viewController: UIViewController,
                                   animated: Bool = true) {
        let contentView = topMostViewController.oldestParent.view.snapshotView(afterScreenUpdates: true)
        let rootViewController = ResumeDismissViewController(contentView: contentView)
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.view.backgroundColor = .clear

        let configuration = PresentationConfiguration.default.apply {
            $0.style = .present(PresentConfiguration(navigationType: nil, modalPresentationStyle: .fullScreen, modalTransitionStyle: .crossDissolve, isModalInPresentation: false))
            $0.animated = false
        }

        topMostViewController.show(navigationController, configuration: configuration) {
            navigationController.pushViewController(viewController, animated: animated)
        }
    }

    public func popOverFullScreen(animated: Bool = true, completion: (() -> Void)? = nil) {
        guard let rootViewController = navigationController?.viewControllers.first as? ResumeDismissViewController else {
            assertionFailure("Cannot detect Over Full Screen")
            return
        }
        rootViewController.dismissHandler = completion
        navigationController?.popToRootViewController(animated: animated)
    }
}

final class ResumeDismissViewController: UIViewController {
    private var appearCount: Int = 0

    private let contentView: UIView

    var dismissHandler: (() -> Void)?

    init(contentView: UIView?) {
        self.contentView = contentView ?? UIView()
        super.init(nibName: nil, bundle: nil)
    }

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

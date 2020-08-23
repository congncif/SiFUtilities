//
//  PushDemoViewController.swift
//  SiFUtilities_Example
//
//  Created by NGUYEN CHI CONG on 8/22/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SiFUtilities
import UIKit

final class PushDemoViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.activeNavigationBar?.setBackgroundImage(UIImage(), for: .default)
        self.activeNavigationBar?.shadowImage = UIImage()
        self.activeNavigationBar?.titleTextAttributes = [.foregroundColor: UIColor.white]
    }

    @IBAction private func pushButtonDidTap() {
//        let exvc = EXViewController.instantiateFromMainStoryboard()
//        pushOverFullScreen(exvc)
    }

    @IBAction func unwindPop(_ segue: UIStoryboardSegue) {}
}

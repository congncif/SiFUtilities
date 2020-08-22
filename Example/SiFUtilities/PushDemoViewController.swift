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

    @IBAction private func pushButtonDidTap() {
//        let exvc = EXViewController.instantiateFromMainStoryboard()
//        pushOverFullScreen(exvc)
    }
    
    @IBAction func unwindPop(_ segue: UIStoryboardSegue) {}
}

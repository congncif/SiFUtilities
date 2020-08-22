//
//  UnwindPopViewController.swift
//  SiFUtilities_Example
//
//  Created by NGUYEN CHI CONG on 8/22/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class Push1ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

class UnwindPopViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

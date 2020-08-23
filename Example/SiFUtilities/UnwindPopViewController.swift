//
//  UnwindPopViewController.swift
//  SiFUtilities_Example
//
//  Created by NGUYEN CHI CONG on 8/22/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SiFUtilities
import UIKit

class Push1ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Push 1 view controller"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let color = UIImage.image(color: .white)

        navigationController?.setNavigationBarHidden(false, animated: true)

        self.activeNavigationBar?.setBackgroundImage(color, for: .default)
        self.activeNavigationBar?.shadowImage = UINavigationBar().shadowImage
        self.activeNavigationBar?.titleTextAttributes = [.foregroundColor: UIColor.black]
    }
}

class UnwindPopViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

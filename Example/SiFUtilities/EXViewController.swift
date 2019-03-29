//
//  EXViewController.swift
//  SiFUtilities_Example
//
//  Created by FOLY on 3/20/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import Localize_Swift
import SiFUtilities

class EXViewController: UIViewController {
    @IBOutlet weak var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel(frame: CGRect(x: 0, y: 100, width: 100, height: 50))
        label.textLocalizedKey = "Hello"
        
        view.addSubview(label)
    }
    
    private var flag: Bool = true
    
    @IBAction func tap() {
//        self.hideOverlay()
        flag = !flag
        
        let lang = flag ? "en" : "vi-VN"
        
        Localize.setCurrentLanguage(lang)
    }
    
    @IBAction func tap2() {
       button.normalTitleLocalizedKey = "dcm"
    }

    override func didRemoveFromParent() {
        print("Backing from prarent")
    }
}

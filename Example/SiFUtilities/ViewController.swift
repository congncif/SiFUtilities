//
//  ViewController.swift
//  SiFUtilities
//
//  Created by NGUYEN CHI CONG on 05/29/2016.
//  Copyright (c) 2016 NGUYEN CHI CONG. All rights reserved.
//

import UIKit
import SiFUtilities

class Test: KeyValueProtocol {
    var name: String?
    var address: String?
    
    var mapKeys: [String : String] {
        return ["name" : "nameMapped"]
    }
}

class Test2: Test {
    var age: Int?
    
    override var mapKeys: [String : String] {
        var keys = super.mapKeys
        keys["age"] = "ageMapped"
        return keys
    }
}

class AdAttribute: KeyValueProtocol {
    var id: String = ""
    var scope: String = "XPFeedScope.global.rawValue"
    var type: String = "XPFeedType.event.rawValue"
    var title: String?
}

class Test3: NSObject, KeyValueProtocol {
    var test2: Test2 = Test2()
    var attr: AdAttribute = AdAttribute()
}

public enum APIEndpoint: String, EndpointProtocol {
    case login
    enum work: String, EndpointProtocol {
        case examEp = "exam_ep"
        case clgt = "clgt/%d"
        case xxx = "xxx/%@/abc/%d"
    }
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let test = Test()
//        test.name = "clgt"
//        test.address = "HN"
//        print(test.dictionary)
//        print(test.JSONString!)
        
//        let test2 = Test2()
//        test2.name = "XXX"
//        test2.address = "SG"
//
//        let test3 = Test3()
//        test3.test2 = test2
//        test3.attr = AdAttribute()
//
//        print(test3.dictionary)
//        print(test3.JSONString!)
        
        print("XXX==> " + APIEndpoint.login.path())
        print("New path " + APIEndpoint.work.clgt.path(123))
        print("XXX path " + APIEndpoint.work.xxx.path("abc", 123))
    }
    
    override func viewDidDisplay() {
//        DispatchQueue.global().async {
//            let v = self.value()
//            print(v)
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        let blur = UIBlurEffect(style: UIBlurEffectStyle.light)
//        let blurView = UIVisualEffectView(effect: blur)
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.view.showLoading(overlayView: blurView)
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            self.view.hideLoading()
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidFinishLayout() {
        
    }
    
    func value() -> String? {
        let keeper = ValueKeeper<String>(defaultValue: "Default") { completion in
            DispatchQueue.global().asyncAfter(deadline: .now() + 10, execute: {
                completion("Test")
            })
        }
        return keeper.syncValue
    }
    
    @IBAction func tap() {
        let vc = EXViewController.instantiateFromMainStoryboard()
        vc.showOverlay(on: self, animation: { v in
            v.moveInFromLeft()
        })
    }

}


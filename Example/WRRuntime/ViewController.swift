//
//  ViewController.swift
//  WRRuntime
//
//  Created by GodFighter on 03/26/2020.
//  Copyright (c) 2020 GodFighter. All rights reserved.
//

import UIKit
import WRRuntime

class Test: WRRuntimeProtocol {
    var age = 0
    
    public static var wr_swizzleMethods = [(#selector(test1), #selector(test2))]

    @objc dynamic func test1() {
        print("test == 1")
    }

    @objc dynamic func test2() {
        print("test == 2")
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additi

        let test = Test()
        test.test1()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


//
//  ViewController.swift
//  WRRuntime
//
//  Created by GodFighter on 03/26/2020.
//  Copyright (c) 2020 GodFighter. All rights reserved.
//

import UIKit
import WRRuntime

//class Dog: WRRuntimeProtocol {
//    public static var wr_swizzleMethods = [(#selector(eating), #selector(eatUp))]
//
//    @objc dynamic func eating() {
//        print("dog is eating")
//    }
//
//    @objc dynamic func eatUp() {
//        print("dog is eat up")
//    }
//}

extension UITableView: WRRuntimeProtocol {
    public static var wr_swizzleMethods = [(#selector(reloadData), #selector(wr_reloadData))]
    
    @objc public dynamic func wr_reloadData() {
        print("123456")
    }
    

}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additi

//        let dog = Dog()
//        dog.eating()
        
        let tableView = UITableView()
        tableView.reloadData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


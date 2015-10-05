//
//  ViewController.swift
//  FirebaseRxSwiftExtensions
//
//  Created by Maximilian Alexander on 10/04/2015.
//  Copyright (c) 2015 Maximilian Alexander. All rights reserved.
//

import UIKit
import FirebaseRxSwiftExtensions

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let test = Test()
        test.username == "max"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


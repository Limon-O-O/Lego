//
//  ViewController.swift
//  LegoAPI
//
//  Created by Limon-O-O on 03/16/2017.
//  Copyright (c) 2017 Limon-O-O. All rights reserved.
//

import UIKit
import LegoProvider

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let userProvider = LegoProvider<UserAPI>()
    }

}


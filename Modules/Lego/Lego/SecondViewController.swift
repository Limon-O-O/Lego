//
//  SecondViewController.swift
//  Lego
//
//  Created by Limon.F on 19/2/2017.
//  Copyright © 2017 Limon.F. All rights reserved.
//

import UIKit
import CTMediator
import CTMediator_Door

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard let welcomeViewController = CTMediator.sharedInstance().door.welcomeViewController() else {
            return
        }
        navigationController?.pushViewController(welcomeViewController, animated: true)
    }
}


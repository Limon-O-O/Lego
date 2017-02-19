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

        let callbackAction: ([String: Any]) -> Void = { info in
            print("Door callbacked with info: \(info)")
        }

        guard let welcomeViewController = CTMediator.sharedInstance().door.welcomeViewController(with: UIColor.red, callbackAction: callbackAction) else {
            return
        }
        navigationController?.pushViewController(welcomeViewController, animated: true)
    }
}


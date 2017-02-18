//
//  FirstViewController.swift
//  Lego
//
//  Created by Limon.F on 19/2/2017.
//  Copyright © 2017 Limon.F. All rights reserved.
//

import UIKit
import CTMediator
import CTMediator_Tower

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let callbackAction: ([String: Any]) -> Void = { info in
            print("Tower callbacked with info: \(info)")
        }

        let deliverParams: [String: Any] = ["color": UIColor.red, "callbackAction": callbackAction]

        guard let towerViewController = CTMediator.sharedInstance().tower.towerViewController(with: deliverParams) else {
            return
        }
        navigationController?.pushViewController(towerViewController, animated: true)
    }
}


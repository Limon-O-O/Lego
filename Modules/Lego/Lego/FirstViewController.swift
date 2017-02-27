//
//  FirstViewController.swift
//  Lego
//
//  Created by Limon.F on 19/2/2017.
//  Copyright © 2017 Limon.F. All rights reserved.
//

import UIKit
import Mediator
import Mediator_Tower

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let callbackAction: ([String: Any]) -> Void = { info in
            print("Tower callbacked with info: \(info)")
        }

        guard let towerViewController = Mediator.shared.tower.towerViewController(with: UIColor.red, callbackAction: callbackAction) else {
            return
        }
        navigationController?.pushViewController(towerViewController, animated: true)
    }
}


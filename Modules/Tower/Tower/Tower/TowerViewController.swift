//
//  TowerViewController.swift
//  Tower
//
//  Created by Limon.F on 18/2/2017.
//  Copyright © 2017 Limon.F. All rights reserved.
//

import UIKit

class TowerViewController: UIViewController {

    var innateParams: [String: Any] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tower"
        view.backgroundColor = innateParams["color"] as? UIColor
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        (innateParams["callbackAction"] as? ([String: Any]) -> Void)?(["price": "8.8"])
    }
}

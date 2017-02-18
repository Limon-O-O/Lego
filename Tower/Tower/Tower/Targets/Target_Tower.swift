//
//  Target_Tower.swift
//  Tower
//
//  Created by Limon.F on 18/2/2017.
//  Copyright © 2017 Limon.F. All rights reserved.
//

import UIKit

@objc(Target_Tower)
class Target_Tower: NSObject {

    func Action_viewController(params: [String: Any]) -> UIViewController {
        let towerViewController = TowerViewController()
        towerViewController.innateParams = params
        return towerViewController
    }

}

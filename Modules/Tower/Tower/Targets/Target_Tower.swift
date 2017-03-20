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

    func Action_TowerViewController(params: [String: Any]) -> UIViewController {
        let viewController = Storyboard.tower.viewController(of: TowerViewController.self)
        viewController.innateParams = params
        return viewController
    }

}

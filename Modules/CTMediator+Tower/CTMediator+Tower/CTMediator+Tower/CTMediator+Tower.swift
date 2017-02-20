//
//  CTMediator+Tower.swift
//  CTMediator+Tower
//
//  Created by Limon.F on 18/2/2017.
//  Copyright © 2017 Limon.F. All rights reserved.
//

import UIKit
import CTMediator

extension Tower where Base: CTMediator {
    public func towerViewController(with color: UIColor, callbackAction: @escaping (([String: Any]) -> Void)) -> UIViewController? {
        let deliverParams: [String: Any] = ["color": color, "callbackAction": callbackAction]
        return base.performTarget("Tower", action: "TowerViewController", params: deliverParams, shouldCacheTarget: false) as? UIViewController
    }
}

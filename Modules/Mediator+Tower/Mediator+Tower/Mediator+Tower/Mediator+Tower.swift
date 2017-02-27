//
//  Mediator+Tower.swift
//  Mediator+Tower
//
//  Created by Limon on 2017-02-27.

import UIKit
import Mediator

extension Tower where Base: Mediator {

    public func towerViewController(with color: UIColor, callbackAction: @escaping (([String: Any]) -> Void)) -> UIViewController? {
        let deliverParams: [String: Any] = ["color": color, "callbackAction": callbackAction]
        return base.performTarget("Tower", action: "TowerViewController", params: deliverParams, shouldCacheTarget: false) as? UIViewController
    }

}


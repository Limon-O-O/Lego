//
//  Mediator_Tower.swift
//  Mediator_Tower
//
//  Created by Limon on 2017-03-15.

import UIKit
import Mediator

// MARK: - Controllers

extension Tower where Base: Mediator {

    public func towerViewController(with color: UIColor, callbackAction: @escaping (([String: Any]) -> Void)) -> UIViewController? {
        let deliverParams: [String: Any] = ["color": color, "callbackAction": callbackAction]
        return base.performTarget("Tower", action: "TowerViewController", params: deliverParams, shouldCacheTarget: false) as? UIViewController
    }

}

// MARK: - Properties

extension Tower where Base: Mediator {

}

// MARK: - Methods

extension Tower where Base: Mediator {

}


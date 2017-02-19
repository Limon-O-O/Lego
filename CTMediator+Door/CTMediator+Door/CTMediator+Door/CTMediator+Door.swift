//
//  CTMediator+Door.swift
//  CTMediator+Door
//
//  Created by Limon.F on 19/2/2017.
//  Copyright © 2017 Limon.F. All rights reserved.
//

import UIKit
import CTMediator

extension Door where Base: CTMediator {
    public func towerViewController(with color: UIColor, callbackAction: @escaping (([String: Any]) -> Void)) -> UIViewController? {
        let deliverParams: [String: Any] = ["color": color, "callbackAction": callbackAction]
        return base.performTarget("Door", action: "viewController", params: deliverParams, shouldCacheTarget: false) as? UIViewController
    }
}


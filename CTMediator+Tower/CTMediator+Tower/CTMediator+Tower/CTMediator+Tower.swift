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
    public func towerViewController(with params: [String: Any], shouldCacheTarget: Bool = false) -> UIViewController? {
        return base.performTarget("Tower", action: "viewController", params: params, shouldCacheTarget: shouldCacheTarget) as? UIViewController
    }
}

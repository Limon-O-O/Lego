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

    public func welcomeViewController(with color: UIColor, callbackAction: @escaping (([String: Any]) -> Void)) -> UIViewController? {
        let deliverParams: [String: Any] = ["color": color, "callbackAction": callbackAction]
        return base.performTarget("Door", action: "WelcomeViewController", params: deliverParams, shouldCacheTarget: false) as? UIViewController
    }

    public func loginViewController(with color: UIColor, callbackAction: @escaping (([String: Any]) -> Void)) -> UIViewController? {
        let deliverParams: [String: Any] = ["color": color, "callbackAction": callbackAction]
        return base.performTarget("Door", action: "LoginViewController", params: deliverParams, shouldCacheTarget: false) as? UIViewController
    }

    public func phoneNumberPickerViewController(with color: UIColor, callbackAction: @escaping (([String: Any]) -> Void)) -> UIViewController? {
        let deliverParams: [String: Any] = ["color": color, "callbackAction": callbackAction]
        return base.performTarget("Door", action: "PhoneNumberPickerViewController", params: deliverParams, shouldCacheTarget: false) as? UIViewController
    }

    public func profilePickerViewController(with color: UIColor, callbackAction: @escaping (([String: Any]) -> Void)) -> UIViewController? {
        let deliverParams: [String: Any] = ["color": color, "callbackAction": callbackAction]
        return base.performTarget("Door", action: "ProfilePickerViewController", params: deliverParams, shouldCacheTarget: false) as? UIViewController
    }
}


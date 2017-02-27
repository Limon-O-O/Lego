//
//  Mediator+Door.swift
//  Mediator+Door
//
//  Created by Limon on 2017-02-27.

import UIKit
import Mediator

extension Door where Base: Mediator {

    public func welcomeViewController() -> UIViewController? {
        let deliverParams: [String: Any] = [:]
        return base.performTarget("Door", action: "WelcomeViewController", params: deliverParams) as? UIViewController
    }

    public func loginViewController(with color: UIColor, callbackAction: @escaping (([String: Any]) -> Void)) -> UIViewController? {
        let deliverParams: [String: Any] = ["color": color, "callbackAction": callbackAction]
        return base.performTarget("Door", action: "LoginViewController", params: deliverParams) as? UIViewController
    }

    public func phoneNumberPickerViewController(with color: UIColor, callbackAction: @escaping (([String: Any]) -> Void)) -> UIViewController? {
        let deliverParams: [String: Any] = ["color": color, "callbackAction": callbackAction]
        return base.performTarget("Door", action: "PhoneNumberPickerViewController", params: deliverParams) as? UIViewController
    }

    public func profilePickerViewController(with color: UIColor, callbackAction: @escaping (([String: Any]) -> Void)) -> UIViewController? {
        let deliverParams: [String: Any] = ["color": color, "callbackAction": callbackAction]
        return base.performTarget("Door", action: "ProfilePickerViewController", params: deliverParams) as? UIViewController
    }

}


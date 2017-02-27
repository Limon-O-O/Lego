//
//  Mediator+Door.swift
//  Mediator+Door
//
//  Created by Limon on 2017-02-27.

import UIKit
import Mediator

// MARK: - Controllers

extension Door where Base: Mediator {

    public func welcomeViewController(_ callbackAction: @escaping (([String: Any]) -> Void)) -> UIViewController? {
        let deliverParams: [String: Any] = ["callbackAction": callbackAction]
        return base.performTarget("Door", action: "WelcomeViewController", params: deliverParams) as? UIViewController
    }

    public func loginViewController(callbackAction: @escaping (([String: Any]) -> Void)) -> UIViewController? {
        let deliverParams: [String: Any] = ["callbackAction": callbackAction]
        return base.performTarget("Door", action: "LoginViewController", params: deliverParams) as? UIViewController
    }

    public func phoneNumberPickerViewController(callbackAction: @escaping (([String: Any]) -> Void)) -> UIViewController? {
        let deliverParams: [String: Any] = ["callbackAction": callbackAction]
        return base.performTarget("Door", action: "PhoneNumberPickerViewController", params: deliverParams) as? UIViewController
    }

    public func profilePickerViewController(callbackAction: @escaping (([String: Any]) -> Void)) -> UIViewController? {
        let deliverParams: [String: Any] = ["callbackAction": callbackAction]
        return base.performTarget("Door", action: "ProfilePickerViewController", params: deliverParams) as? UIViewController
    }
}

// MARK: - Properties

extension Door where Base: Mediator {

    public func didLogin() -> Bool {
        let result = base.performTarget("Door", action: "DidLogin", params: [:]) as? [String: Any]
        return (result?["result"] as? Bool) ?? false
    }
}

// MARK: - Methods

extension Door where Base: Mediator {

    public func clearUserDefaults() {
        base.performTarget("Door", action: "ClearUserDefaults", params: [:])
    }
}

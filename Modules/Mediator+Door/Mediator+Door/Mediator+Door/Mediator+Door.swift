//
//  Mediator+Door.swift
//  Mediator+Door
//
//  Created by Limon on 2017-02-27.

import UIKit
import Mediator

// MARK: - Controllers

extension Door where Base: Mediator {

    public func welcomeViewController(_ navigationBarHidden: Bool = true, _ callbackAction: @escaping (([String: Any]) -> Void)) -> UIViewController? {
        let deliverParams: [String: Any] = ["navigationBarHidden": navigationBarHidden, "callbackAction": callbackAction]
        return base.performTarget("Door", action: "WelcomeViewController", params: deliverParams) as? UIViewController
    }

    public func presentWelcomeViewController(callbackAction: @escaping (([String: Any]) -> Void)) {
        let deliverParams: [String: Any] = ["navigationBarHidden": false, "callbackAction": callbackAction]
        base.performTarget("Door", action: "PresentWelcomeViewController", params: deliverParams)
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

    public func accessToken() -> String? {
        let result = base.performTarget("Door", action: "AccessToken", params: [:]) as? [String: Any]
        return result?["result"] as? String
    }

    public func userID() -> Int? {
        let result = base.performTarget("Door", action: "UserID", params: [:]) as? [String: Any]
        return result?["result"] as? Int
    }
}

// MARK: - Methods

extension Door where Base: Mediator {

    public func clearUserDefaults() {
        base.performTarget("Door", action: "ClearUserDefaults", params: [:])
    }
}

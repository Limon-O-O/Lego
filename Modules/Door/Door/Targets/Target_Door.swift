//
//  Target_Door.swift
//  Door
//
//  Created by Limon.F on 19/2/2017.
//  Copyright © 2017 Limon.F. All rights reserved.
//

import UIKit

@objc(Target_Door)
class Target_Door: NSObject {}

// MARK: - Controllers

extension Target_Door {

    func Action_WelcomeViewController(params: [String: Any]) -> UIViewController? {
        let navigationController = Storyboard.door.navigationController(with: "DoorNavigationController") as? DoorNavigationController
        navigationController?.innateParams = params
        return navigationController
    }

    func Action_PresentWelcomeViewController(params: [String: Any]) {

        if DoorUserDefaults.didLogin { // 已将登录了，不需要再 present Door
            (params["callbackAction"] as? ([String: Any]) -> Void)?(["result": true])
        } else {

            guard let navigationController = Storyboard.door.navigationController(with: "DoorNavigationController") as? DoorNavigationController else  { return }

            let action: ([String: Any]) -> Void = { [weak navigationController] info in
                navigationController?.dismiss(animated: true, completion: nil)
                (params["callbackAction"] as? ([String: Any]) -> Void)?(info)
            }

            var paramsBuffer = params
            paramsBuffer["callbackAction"] = action
            navigationController.innateParams = paramsBuffer

            UIApplication.shared.keyWindow?.rootViewController?.present(navigationController, animated: true, completion: nil)
        }
    }

    func Action_LoginViewController(params: [String: Any]) -> UIViewController {
        let viewController = Storyboard.login.viewController(of: LoginViewController.self)
        viewController.innateParams = params
        return viewController
    }

    func Action_PhoneNumberPickerViewController(params: [String: Any]) -> UIViewController {
        let viewController = Storyboard.register.viewController(of: PhoneNumberPickerViewController.self)
        viewController.innateParams = params
        return viewController
    }

    func Action_ProfilePickerViewController(params: [String: Any]) -> UIViewController {
        let viewController = Storyboard.register.viewController(of: ProfilePickerViewController.self)
        viewController.innateParams = params
        return viewController
    }
}

// MARK: - Properties

extension Target_Door {

    func Action_AccessToken() -> [String: Any]? {
        return DoorUserDefaults.accessToken.flatMap { accessToken -> [String: Any] in
            return ["result": accessToken]
        }
    }

    func Action_UserID() -> [String: Any]? {
        return DoorUserDefaults.userID.flatMap { accessToken -> [String: Any] in
            return ["result": accessToken]
        }
    }
}

// MARK: - Methods

extension Target_Door {

    func Action_ClearUserDefaults() {
        DoorUserDefaults.clear()
    }
}

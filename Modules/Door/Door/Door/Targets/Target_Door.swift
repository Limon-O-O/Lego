//
//  Target_Door.swift
//  Door
//
//  Created by Limon.F on 19/2/2017.
//  Copyright © 2017 Limon.F. All rights reserved.
//

import UIKit

@objc(Target_Door)
class Target_Door: NSObject {

    func Action_WelcomeViewController(params: [String: Any]) -> UIViewController? {
        let navigationController = Storyboard.door.navigationController(with: "DoorNavigationController") as? UINavigationController
        // TODO: 去掉强制拆包
        return navigationController!
    }

    func Action_LoginViewController(params: [String: Any]) -> UIViewController {
        let viewController = LoginViewController()
        viewController.innateParams = params
        return viewController
    }

    func Action_PhoneNumberPickerViewController(params: [String: Any]) -> UIViewController {
        let viewController = PhoneNumberPickerViewController()
        viewController.innateParams = params
        return viewController
    }

    func Action_ProfilePickerViewController(params: [String: Any]) -> UIViewController {
        let viewController = ProfilePickerViewController()
        viewController.innateParams = params
        return viewController
    }

}


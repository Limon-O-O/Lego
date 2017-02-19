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

    func Action_WelcomeViewController(params: [String: Any]) -> UIViewController {
        let towerViewController = WelcomeViewController()
        towerViewController.innateParams = params
        return towerViewController
    }

    func Action_LoginViewController(params: [String: Any]) -> UIViewController {
        let towerViewController = LoginViewController()
        towerViewController.innateParams = params
        return towerViewController
    }

    func Action_PhoneNumberPickerViewController(params: [String: Any]) -> UIViewController {
        let towerViewController = PhoneNumberPickerViewController()
        towerViewController.innateParams = params
        return towerViewController
    }

    func Action_ProfilePickerViewController(params: [String: Any]) -> UIViewController {
        let towerViewController = ProfilePickerViewController()
        towerViewController.innateParams = params
        return towerViewController
    }

}


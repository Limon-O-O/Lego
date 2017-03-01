//
//  Target_Profile.swift
//  Profile
//
//  Created by Limon on 2017-03-01.

import UIKit

@objc(Target_Profile)
class Target_Profile: NSObject {}

// MARK: - Controllers

extension Target_Profile {

    func Action_ProfileViewController(params: [String: Any]) -> UIViewController {
        let viewController = ProfileViewController()
        viewController.innateParams = params
        return viewController
    }

    func Action_FetchProfileViewController(params: [String: Any]) {
        let viewController = ProfileViewController()
        viewController.innateParams = params
        (params["successHandler"] as? (UIViewController) -> Void)?(viewController)
    }

}

// MARK: - Properties

extension Target_Profile {

}

// MARK: - Methods

extension Target_Profile {

}

// MARK: - Before Action

extension Target_Profile {

    func BeforeAction_ShouldLogin(params: [String: Any]) -> [String: Any] {

        print("BeforeAction \(params)")
        return ["result": true]
    }
}

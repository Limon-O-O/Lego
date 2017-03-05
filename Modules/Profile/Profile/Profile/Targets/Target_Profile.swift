//
//  Target_Profile.swift
//  Profile
//
//  Created by Limon on 2017-03-01.

import UIKit

@objc(Target_Profile)
class Target_Profile: NSObject {

    struct BeforeAction {

        private init() {}

        enum SholdLogin: String {
            case profileViewController
            case fetchProfileViewController

            var value: Bool {
                switch self {
                case .profileViewController:
                    return true
                case .fetchProfileViewController:
                    return true
                }
            }
        }
    }

}

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

    func BeforeAction_ShouldLogin(actionName: String) -> [String: Any] {
        let firstIndex = actionName.index(actionName.startIndex, offsetBy: 1)
        let rawValue = actionName.substring(to: firstIndex).lowercased() + actionName.substring(from: firstIndex)
        let result = BeforeAction.SholdLogin(rawValue: rawValue)?.value ?? true
        return ["result": result]
    }
}

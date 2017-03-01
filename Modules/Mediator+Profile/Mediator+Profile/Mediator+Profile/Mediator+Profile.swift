//
//  Mediator+Profile.swift
//  Mediator+Profile
//
//  Created by Limon on 2017-03-01.

import UIKit
import Mediator



// MARK: - Controllers

extension Profile where Base: Mediator {

    public func profileViewController(callbackAction: @escaping (([String: Any]) -> Void)) -> UIViewController? {
        let deliverParams: [String: Any] = ["callbackAction": callbackAction]
        return base.performTarget("Profile", action: "ProfileViewController", params: deliverParams) as? UIViewController
    }

    public func fetchProfileViewController(successHandler: @escaping ((UIViewController) -> Void), failHandler: @escaping (([String: Any]) -> Void)) {
        let deliverParams: [String: Any] = ["successHandler": successHandler, "failHandler": failHandler]
        base.performTarget("Profile", action: "FetchProfileViewController", params: deliverParams)
    }

}

// MARK: - Properties

extension Profile where Base: Mediator {

    

}

// MARK: - Methods

extension Profile where Base: Mediator {

}


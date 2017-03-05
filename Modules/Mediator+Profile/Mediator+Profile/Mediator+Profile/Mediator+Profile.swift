//
//  Mediator+Profile.swift
//  Mediator+Profile
//
//  Created by Limon on 2017-03-01.

import UIKit
import Mediator


// MARK: - Controllers

extension Profile where Base: Mediator {

    public func profileViewController() -> UIViewController? {
        return base.performTarget("Profile", action: "ProfileViewController", params: [:]) as? UIViewController
    }

    public func fetchProfileViewController(successHandler: @escaping ((UIViewController) -> Void)) {
        let deliverParams: [String: Any] = ["successHandler": successHandler]
        base.performTarget("Profile", action: "FetchProfileViewController", params: deliverParams)
    }

}

// MARK: - Properties

extension Profile where Base: Mediator {

    

}

// MARK: - Methods

extension Profile where Base: Mediator {

}


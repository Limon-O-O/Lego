//
//  Storyboard.swift
//  Pods
//
//  Created by Limon.F on 26/2/2017.
//
//

import UIKit

enum Storyboard: String {

    case door
    case login
    case register

    var instance: UIStoryboard {
        let bundle = Bundle(for: Empty.self)
        return UIStoryboard(name: self.rawValue.capitalized, bundle: bundle)
    }

    func viewController<T: UIViewController>(of viewControllerType: T.Type) -> T {
        return instance.instantiateViewController(withIdentifier: "\(T.self)") as! T
    }

    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }

    func navigationController(with identifier: String) -> UIViewController {
        return instance.instantiateViewController(withIdentifier: identifier)
    }
}

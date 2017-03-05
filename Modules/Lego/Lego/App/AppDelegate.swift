//
//  AppDelegate.swift
//  Lego
//
//  Created by Limon.F on 19/2/2017.
//  Copyright © 2017 Limon.F. All rights reserved.
//

import UIKit
import Mediator
import Networking
import Mediator_Door

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        Networking.ServiceConfigure.accessToken = Mediator.shared.door.accessToken()
        Networking.ServiceConfigure.Environment.stringValue = Environment.value.rawValue

        Mediator.shared.door.clearUserDefaults()

        if !LegoUserDefaults.didLogin {
            // startDoorStory()
        }

        Mediator.shared.coolie = self

        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let result = Mediator.shared.performAction(with: url)
        return result != nil
    }
}

// MARK: - Coolie

extension AppDelegate: Coolie {

    func mediatorRequestPermission(with successHandler: @escaping () -> Void) {

        Mediator.shared.door.presentWelcomeViewController { _ in
            // 登录成功
            successHandler()
        }
    }

    func mediatorCannotParse(_ url: URL) {
        print("Mediator can not parse url: \(url)")
    }

    func mediatorCannotMatchScheme(of url: URL) {
        print("Mediator can not parse scheme of url: \(url)")
    }

    func mediatorCannotMatch(_ target: String, action: String, of url: URL) {
        print("Mediator can not match `\(target)` or `\(action)` of url: \(url)")
    }

    func mediatorCannotMatch(_ user: String, password: String, of url: URL) -> Bool {
        print("Mediator can not match `\(user)` or `\(password)` of url: \(url)")
        return false
    }

    func mediatorNotFound(_ target: String) {
        print("Mediator not found \(target)")
    }

    func mediatorNotFound(_ action: String, of target: NSObject) {
        print("Mediator not found \(action) of \(target)")
    }
}

// MARK: - Custom Methods

extension AppDelegate {

    func startDoorStory() {

        let callbackAction: ([String: Any]) -> Void = { [weak self] info in

            guard let _ = info["userID"] as? Int else { return }

            self?.startMainStory()

            print("Door callbacked with info: \(info)")
        }

        let welcomeViewController = Mediator.shared.door.welcomeViewController { info in callbackAction(info) }
        guard let controller = welcomeViewController else { return }
        window?.rootViewController = controller
    }

    func startMainStory() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootViewController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController")
        window?.rootViewController = rootViewController
    }

}


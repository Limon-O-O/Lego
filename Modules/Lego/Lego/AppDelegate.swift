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

        let didLogin = Mediator.shared.door.didLogin()

        Networking.ServiceConfigure.accessToken = Mediator.shared.door.accessToken()

        startDoorStory()
        if !didLogin {
        }

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {}

}

// MARK: - Custom Methods

extension AppDelegate {

    func startDoorStory() {

        let callbackAction: ([String: Any]) -> Void = { [weak self] info in

            guard let _ = info["userID"] as? Int else { return }

            self?.startMainStory()

            print("Door callbacked with info: \(info)")
        }

        guard let welcomeViewController = Mediator.shared.door.welcomeViewController(callbackAction) else {
            return
        }
        window?.rootViewController = welcomeViewController
    }

    func startMainStory() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootViewController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController")
        window?.rootViewController = rootViewController
    }

}


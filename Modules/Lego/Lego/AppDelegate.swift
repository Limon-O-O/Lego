//
//  AppDelegate.swift
//  Lego
//
//  Created by Limon.F on 19/2/2017.
//  Copyright © 2017 Limon.F. All rights reserved.
//

import UIKit
import CTMediator
import CTMediator_Door

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let didLogin = false

        if !didLogin {
            startDoorStory()
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
        guard let welcomeViewController = CTMediator.sharedInstance().door.welcomeViewController() else {
            return
        }
        window?.rootViewController = welcomeViewController
    }

}


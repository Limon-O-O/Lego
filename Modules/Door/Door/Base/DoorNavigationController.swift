//
//  DoorNavigationController.swift
//  Door
//
//  Created by Limon on 27/02/2017.
//  Copyright © 2017 Limon.F. All rights reserved.
//

import UIKit
import LegoKit

class DoorNavigationController: NavigationController {

    var innateParams: [String: Any] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        (topViewController as? WelcomeViewController)?.innateParams = innateParams
    }
}

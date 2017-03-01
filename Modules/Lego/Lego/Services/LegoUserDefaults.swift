//
//  LegoUserDefaults.swift
//  Lego
//
//  Created by Limon on 27/02/2017.
//  Copyright © 2017 Limon.F. All rights reserved.
//

import Foundation
import Mediator
import Mediator_Door

struct LegoUserDefaults {

    fileprivate static let defaults = UserDefaults(suiteName: "top.limon.lego")!

    private init() {}

    static func synchronize() {
        defaults.synchronize()
    }

    static func clear() {
        for key in defaults.dictionaryRepresentation().keys {
            defaults.removeObject(forKey: key)
        }
        defaults.synchronize()
    }
}

extension LegoUserDefaults {

    fileprivate enum Keys: String {
        case didSayHi
    }
}

extension LegoUserDefaults {

    static var didLogin: Bool {
        return Mediator.shared.door.didLogin()
    }

    static var didSayHi: Bool {
        get {
            return defaults.bool(forKey: Keys.didSayHi.rawValue) 
        }
        set {
            defaults.set(newValue, forKey: Keys.didSayHi.rawValue)
        }
    }
}


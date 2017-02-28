//
//  DoorUserDefaults.swift
//  Door
//
//  Created by Limon on 27/02/2017.
//  Copyright © 2017 Limon.F. All rights reserved.
//

import Foundation
import Networking

struct DoorUserDefaults {

    fileprivate static let defaults = UserDefaults(suiteName: "top.limon.door")!

    private init() {}

    fileprivate enum Keys: String {
        case userID
        case accessTokenV1
    }

    static func synchronize() {
        defaults.synchronize()
    }

    static var didLogin: Bool {
        return accessToken != nil && userID != nil
    }

    static func clear() {
        for key in defaults.dictionaryRepresentation().keys {
            defaults.removeObject(forKey: key)
        }
        defaults.synchronize()
    }
}

extension DoorUserDefaults {

    fileprivate static var _accessToken: String?
    static var accessToken: String? {
        get {
            if _accessToken == nil {
                _accessToken = defaults.string(forKey: Keys.accessTokenV1.rawValue)
            }
            return _accessToken
        }
        set {
            _accessToken = newValue
            defaults.set(newValue, forKey: Keys.accessTokenV1.rawValue)
            Networking.ServiceConfigure.accessToken = newValue
        }
    }

    static var userID: Int? {
        get {
            return defaults.integer(forKey: Keys.userID.rawValue)
        }
        set {
            defaults.set(newValue, forKey: Keys.userID.rawValue)
        }
    }
}


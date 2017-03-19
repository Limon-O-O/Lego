//
//  DoorUserDefaults.swift
//  Door
//
//  Created by Limon on 27/02/2017.
//  Copyright © 2017 Limon.F. All rights reserved.
//

import Foundation
import LegoContext

struct DoorUserDefaults {

    fileprivate static let defaults = UserDefaults(suiteName: "top.limon.door")!

    private init() {}

    static func synchronize() {
        defaults.synchronize()
    }

    static func clear() {

        accessToken = nil

        for key in defaults.dictionaryRepresentation().keys {
            defaults.removeObject(forKey: key)
        }

        defaults.synchronize()
    }
}

extension DoorUserDefaults {

    fileprivate enum Keys: String {
        case userID
        case accessTokenV1
    }
}

extension DoorUserDefaults {

    static var didLogin: Bool {
        return accessToken != nil && userID != nil
    }

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
            LegoContext.accessToken = newValue
        }
    }

    static var userID: Int? {
        get {
            let id = defaults.integer(forKey: Keys.userID.rawValue)
            return id == 0 ? nil : id
        }
        set {
            LegoContext.userID = newValue
            defaults.set(newValue, forKey: Keys.userID.rawValue)
        }
    }
}


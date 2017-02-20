//
//  ServiceConfigure.swift
//  NetworkingService
//
//  Created by Limon on 20/02/2017.
//  Copyright © 2017 Limon.F. All rights reserved.
//

import Foundation

public struct ServiceConfigure {

    static let apiHost: String = {
        switch ServiceConfigure.Environment.value {
        case .debug:
            return "test.limon.top"
        case .enterprise, .release:
            return "glb.limon.top"
        }
    }()

    public static var accessToken: String?

    public enum Environment: String {
        case debug
        case enterprise
        case release

        public static var stringValue: String = Environment.release.rawValue {
            willSet {
                guard newValue != stringValue, let new = Environment(rawValue: newValue) else { return }
                value = new
            }
        }

        static var value: Environment = .release
    }

    static var bundle: Bundle {
        let classBundle = Bundle(for: Empty.self)
        if let bundleURL = classBundle.url(forResource: "NetworkingBundle", withExtension: "bundle") {
            return Bundle(url: bundleURL) ?? classBundle
        } else {
            return classBundle
        }
    }

    static let tableName: String = "NetworkingLocalizable"
}

class Empty {}

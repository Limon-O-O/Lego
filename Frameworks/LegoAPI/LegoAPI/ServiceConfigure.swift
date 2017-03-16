//
//  ServiceConfigure.swift
//  LegoAPI
//
//  Created by Limon on 16/03/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import LegoContext

struct ServiceConfigure {

    class Empty {}

    static let apiHost: String = {
        switch LegoContext.Environment.value {
        case .debug:
            return "test.limon.top"
        case .enterprise, .release:
            return "glb.limon.top"
        }
    }()

    public static var accessToken: String?

    static var bundle: Bundle {
        let classBundle = Bundle(for: Empty.self)
        if let bundleURL = classBundle.url(forResource: "LegoAPIBundle", withExtension: "bundle") {
            return Bundle(url: bundleURL) ?? classBundle
        } else {
            return classBundle
        }
    }

    static let tableName: String = "LegoAPILocalizable"

    // Beta/1.0.0 (iPhone; iOS 8.1; Scale/2.00)
    static let userAgent: String = {

        let key: String = {
            switch LegoContext.Environment.value {
            case .debug:
                return "DEV"
            case .enterprise:
                return "Beta"
            case .release:
                return "Lego"
            }
        }()

        let version = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? "1.0.0"

        return "\(key)/\(version) (\(UIDevice.current.model); iOS \(UIDevice.current.systemVersion); Scale/\(UIScreen.main.scale))"
    }()

    static let language: String = {
        return NSLocalizedString("locate", tableName: ServiceConfigure.tableName, bundle: ServiceConfigure.bundle, comment: "")
    }()
}

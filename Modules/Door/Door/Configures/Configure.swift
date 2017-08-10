//
//  Configure.swift
//  Crisp
//
//  Created by k on 11/11/2016.
//  Copyright © 2016 egg. All rights reserved.
//

import UIKit

enum Environment: String {
    case debug
    case enterprise
    case release

    static let value: Environment = {
        #if DEBUG
            return .debug
        #elseif ENTERPRISE
            return .enterprise
        #else
            return .release
        #endif
    }()
}

struct Configure {

    static let termsURL = "www.limon.top"
    static let privacyURL = "www.limon.top"

    static let callMeInSeconds: Int = 30
    static let verifyCodeLength: Int = 4

    enum Account {

        enum Wechat {
            static let appID = "wx4868b35061f87885"
            static let appKey = "64020361b8ec4c99936c0e3999a9f249"
        }

        enum Weibo {
            static let appID = "1772193724"
            static let appKey = "453283216b8c885dad2cdb430c74f62a"
            static let redirectURL = "http://www.limon.top"
        }

        struct QQ {
            static let appID = "1104881792"
        }
    }

    class Empty {}

    static var bundle: Bundle {
        let classBundle = Bundle(for: Empty.self)
        if let bundleURL = classBundle.url(forResource: "DoorBundle", withExtension: "bundle") {
            return Bundle(url: bundleURL) ?? classBundle
        } else {
            return classBundle
        }
    }

    static let tableName: String = "DoorLocalizable"
}

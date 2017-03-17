//
//  ServiceConfigure.swift
//  LegoProvider
//
//  Created by Limon on 17/03/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation

struct ServiceConfigure {

    class Empty {}

    static var bundle: Bundle {
        let classBundle = Bundle(for: Empty.self)
        if let bundleURL = classBundle.url(forResource: "LegoProviderBundle", withExtension: "bundle") {
            return Bundle(url: bundleURL) ?? classBundle
        } else {
            return classBundle
        }
    }

    static let tableName: String = "LegoProviderLocalizable"
}

//
//  Configure.swift
//  Lego
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

    static var didLogin: Bool {
        return false
    }
}

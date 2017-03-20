//
//  LegoContext.swift
//  LegoContext
//
//  Created by Limon on 06/03/2017.
//  Copyright © 2017 Limon.F. All rights reserved.
//

import Foundation

public struct LegoContext {

    public enum Environment: String {
        case debug
        case enterprise
        case release

        public static let value: Environment = {
            #if DEBUG
                return .debug
            #elseif ENTERPRISE
                return .enterprise
            #else
                return .release
            #endif
        }()
    }

    public static var didLogin: Bool {
        return accessToken != nil && userID != nil
    }

    public static var userID: Int?

    public static var nickname: String?

    public static var accessToken: String?

}

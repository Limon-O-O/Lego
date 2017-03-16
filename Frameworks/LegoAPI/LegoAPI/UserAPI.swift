//
//  UserAPI.swift
//  LegoAPI
//
//  Created by Limon on 16/03/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Moya

public enum UserAPI {
    case login([String: String])
    case createUser([String: String])
}

extension UserAPI: LegoAPI {

    public var path: String {

        switch self {
        case .login:
            return "/user"
        case .createUser:
            return "/user"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .createUser:
            return .post
        }
    }

    public var parameters: [String : Any]? {
        switch self {
        case .login(let params):
            return params

        case .createUser(let params):
            return params
        }
    }

    /// 方便于单元测试…暂时忽略，具体参考开源库 Ello
    public var sampleData: Data {
        return Data()
    }
}

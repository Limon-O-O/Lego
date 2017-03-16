//
//  LegoAPI.swift
//  LegoAPI
//
//  Created by Limon on 16/03/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import MoyaSugar

public protocol SugarTargetType: TargetType {
    var headers: [String: String]? { get }
}

public extension SugarTargetType {
    public var headers: [String: String]? {
        return nil
    }
}

protocol LegoAPI: SugarTargetType {}

extension LegoAPI {

    public var baseURL: URL {
        return URL(string: "https://\(ServiceConfigure.apiHost)/v1")!
    }

    public var parameterEncoding: Moya.ParameterEncoding {
        if self.method == .get || self.method == .head {
            return URLEncoding.default
        }
        else {
            return JSONEncoding.default
        }
    }

    public var headers: [String: String]? {

        var assigned: [String: String] = [
            "User-Agent": ServiceConfigure.userAgent,
            "Accept-Language": ServiceConfigure.language
        ]

        if let token = ServiceConfigure.accessToken {
            assigned["Lego-TOKEN"] = token
        }

        return assigned
    }

    public var task: Task {
        return .request
    }
}

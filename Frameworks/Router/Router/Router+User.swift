//
//  Router+User.swift
//  Router
//
//  Created by Limon on 16/03/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Alamofire

extension Router {

    public enum User: URLRequestConvertible {

        case login([String: String])
        case createUser([String: String])

        var method: Alamofire.HTTPMethod {
            switch self {
            case .login, .createUser:
                return .post
            }
        }

        var path: String {
            switch self {
            case .login:
                return "/users"
            case .createUser:
                return "/users"
            }
        }

        public func asURLRequest() throws -> URLRequest {
            var urlRequest = URLRequest.buildRequest(path: path, method: method)
            switch self {
            case .login(let parameters), .createUser(let parameters):
                urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            }
            return urlRequest
        }
    }
}

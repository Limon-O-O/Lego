//
//  Router+Action.swift
//  Router
//
//  Created by Limon on 16/03/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Alamofire

extension Router {

    public enum Action: URLRequestConvertible {

        case test1([String: Any])
        case test2

        var method: Alamofire.HTTPMethod {
            switch self {
            case .test1:
                return .post
            case .test2:
                return .get
            }
        }

        var path: String {
            switch self {
            case .test1:
                return "/actions/test1"
            case .test2:
                return "/actions/test2"
            }
        }

        public func asURLRequest() throws -> URLRequest {
            var urlRequest = URLRequest.buildRequest(path: path, method: method)
            switch self {
            case .test1(let parameters):
                urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            case .test2:
                break
            }
            return urlRequest
        }
    }
}

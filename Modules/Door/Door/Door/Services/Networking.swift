//
//  Networking.swift
//  Door
//
//  Created by Limon.F on 27/2/2017.
//  Copyright © 2017 Limon.F. All rights reserved.
//

import RxSwift
import Alamofire
import Networking

extension Router {

    enum User: URLRequestConvertible {

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

extension NetworkingService {

    static func login<T: Mappable>(phoneNumber: String, mapper: T.Type) -> Observable<T> {
        let parameters = ["phone_number": phoneNumber]
        return result(request: Router.User.login(parameters), mapper: mapper)
    }

    static func register<T: Mappable>(phoneNumber: String, mapper: T.Type) -> Observable<T> {
        let parameters = ["phone_number": phoneNumber]
        return result(request: Router.User.createUser(parameters), mapper: mapper)
    }
}

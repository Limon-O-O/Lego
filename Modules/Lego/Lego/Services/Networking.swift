//
//  Networking.swift
//  Lego
//
//  Created by Limon.F on 27/2/2017.
//  Copyright © 2017 Limon.F. All rights reserved.
//

import RxSwift
import Alamofire
import Networking

extension Router {

    enum Action: URLRequestConvertible {

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

extension NetworkingService {

    static func test1<T: Mappable>(phoneNumber: String, mapper: T.Type) -> Observable<T> {
        let parameters = ["phone_number": phoneNumber]
        return result(request: Router.Action.test1(parameters), mapper: mapper)
    }

    static func test2() -> Observable<Bool> {
        return send(request: Router.Action.test2)
    }
}

//
//  Networking.swift
//  Door
//
//  Created by Limon.F on 27/2/2017.
//  Copyright © 2017 Limon.F. All rights reserved.
//

import RxSwift
import Router
import Alamofire
import Networking

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

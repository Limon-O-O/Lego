//
//  Networking.swift
//  Lego
//
//  Created by Limon.F on 27/2/2017.
//  Copyright © 2017 Limon.F. All rights reserved.
//

import RxSwift
import Alamofire
import Router
import Networking

extension NetworkingService {

    static func test1<T: Mappable>(phoneNumber: String, mapper: T.Type) -> Observable<T> {
        let parameters = ["phone_number": phoneNumber]
        return result(request: Router.Action.test1(parameters), mapper: mapper)
    }

    static func test2() -> Observable<Bool> {
        return send(request: Router.Action.test2)
    }
}

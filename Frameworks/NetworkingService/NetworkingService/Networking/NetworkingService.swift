//
//  NetworkingService.swift
//  NetworkingService
//
//  Created by Limon on 20/02/2017.
//  Copyright © 2017 Limon.F. All rights reserved.
//

import Alamofire
import RxSwift

public struct NetworkingErrorCode {
    public static let networkingError = 40000
    public static let invalidURL = 40001
    public static let jsonSerializationFailed = 40002
}

public struct NetworkingError: Error {

    public let code: Int
    public let failureReason: String

    public init(code: Int, failureReason: String) {
        self.code = code
        self.failureReason = failureReason
    }

    public static var `default`: NetworkingError {
        return NetworkingError(code: NetworkingErrorCode.networkingError, failureReason: NSLocalizedString("The network isn't available", tableName: ServiceConfigure.tableName, bundle: ServiceConfigure.bundle, comment: ""))
    }

    public static var invalidURL: NetworkingError {
        return NetworkingError(code: NetworkingErrorCode.invalidURL, failureReason: NSLocalizedString("Invalid URL", tableName: ServiceConfigure.tableName, bundle: ServiceConfigure.bundle, comment: ""))
    }

    public static var jsonSerializationFailed: NetworkingError {
        return NetworkingError(code: NetworkingErrorCode.jsonSerializationFailed, failureReason: NSLocalizedString("Response json serialization failed", tableName: ServiceConfigure.tableName, bundle: ServiceConfigure.bundle, comment: ""))
    }

    public var localizedDescription: String {
        return failureReason
    }
}

public protocol Mappable {

    static func mapping(json: [String: Any]) -> Self?

    init?(json: [String: Any])
}

public extension Mappable {

    func mapping(json: [String: Any]) -> Self? {
        return Self(json: json)
    }
}

extension Alamofire.DataRequest {

    @discardableResult
    fileprivate func response(_ completionHandler: @escaping (Any?, NetworkingError?) -> Void) -> Self {

        return response(queue: nil, responseSerializer: DataRequest.jsonResponseSerializer(options: .allowFragments)) { response in

            var error: NetworkingError?
            var json: Any?

            defer {
                completionHandler(json, error)
            }

            guard let httpURLResponse = response.response else {
                if ServiceConfigure.Environment.value == .debug {
                    print(response.debugDescription)
                }
                if let unwrappedError = response.result.error as? NSError {
                    // 错误码大全：https://github.com/apple/swift-corelibs-foundation/blob/master/Foundation/NSURLError.swift
                    error = NetworkingError(code: unwrappedError.code, failureReason: unwrappedError.localizedDescription + " " + "\(unwrappedError.code)")
                } else {
                    error = NetworkingError.default
                }
                return
            }

            if httpURLResponse.statusCode == 200 {
                json = response.result.value

            } else {
                guard let responseJSON = response.result.value as? [String: Any], let errorCode = responseJSON["error_code"] as? Int, let message = responseJSON["error_msg"] as? String else {
                    if let err = response.result.error {
                        error = NetworkingError(code: httpURLResponse.statusCode, failureReason: err.localizedDescription)
                    } else {
                        error = NetworkingError.default
                    }

                    return
                }

                error = NetworkingError(code: errorCode, failureReason: message)
            }
            
            return
        }
    }
}

public struct NetworkingService {

    fileprivate static let securityManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60.0
        let sessionManager = Alamofire.SessionManager(configuration: configuration)
        return sessionManager
    }()

    public static func result<T: Mappable>(request: URLRequestConvertible, mapper: T.Type, key: String = "result") -> Observable<T> {

        return Observable.create { observer -> Disposable in

            let request = securityManager.request(request).response { json, error in

                if let error = error {
                    observer.onError(error)
                    return
                }

                guard let json = json as? [String: Any], let resultJSON = json[key] as? [String: Any], let result = mapper.mapping(json: resultJSON) else {
                    observer.onError(NetworkingError.jsonSerializationFailed)
                    return
                }

                observer.onNext(result)
                observer.onCompleted()
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
}

extension NetworkingService {

    public static func login<T: Mappable>(phoneNumber: String, mapper: T.Type) -> Observable<T> {
        let parameters = ["phone_number": phoneNumber]
        return result(request: Router.User.login(parameters), mapper: mapper)
    }

    public static func register<T: Mappable>(phoneNumber: String, mapper: T.Type) -> Observable<T> {
        let parameters = ["phone_number": phoneNumber]
        return result(request: Router.User.createUser(parameters), mapper: mapper)
    }
}

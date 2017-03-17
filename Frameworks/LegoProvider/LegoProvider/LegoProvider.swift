//
//  LegoProvider.swift
//  LegoProvider
//
//  Created by Limon on 16/03/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Moya
import RxSwift
import Alamofire
import MoyaSugar

struct LegoManager {

    static var serverTrustPolicies: [String: ServerTrustPolicy] {
        let policyDict: [String: ServerTrustPolicy]
        // TODO:
        policyDict = [:]
        return policyDict
    }

    static var manager: SessionManager {
        let config = URLSessionConfiguration.default
        config.sharedContainerIdentifier = "group.limon.top"
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 30
        return SessionManager(
            configuration: config,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: LegoManager.serverTrustPolicies)
        )
    }

    static var shareExtensionManager: SessionManager {
        let config = URLSessionConfiguration.background(withIdentifier: "top.limon.shareextension.background")
        config.sharedContainerIdentifier = "group.limon.top"
        config.sessionSendsLaunchEvents = false
        return SessionManager(
            configuration: config,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: LegoManager.serverTrustPolicies)
        )
    }
}

public class LegoProvider<Target: SugarTargetType>: RxMoyaProvider<Target> {

    static func endpointClosure(_ target: Target) -> Endpoint<Target> {
        let sampleResponseClosure = { return EndpointSampleResponse.networkResponse(200, target.sampleData) }
        let method = target.method
        let parameters = target.parameters
        let url = target.baseURL.appendingPathComponent(target.path).absoluteString
        return Endpoint<Target>(url: url, sampleResponseClosure: sampleResponseClosure, method: method, parameters: parameters, parameterEncoding: target.parameterEncoding, httpHeaderFields: target.headers)
    }

    public override func request(_ token: Target) -> Observable<Response> {
        return Observable.create { observer in
            let cancellableToken = self.request(token) { result in
                switch result {
                case let .success(response):
                    observer.onNext(response)
                    observer.onCompleted()
                case let .failure(error):
                    // response.response 为空的时候 error 是 underlying(error)
                    switch error {
                    case .underlying(let error as NSError):
                        // 错误码大全：https://github.com/apple/swift-corelibs-foundation/blob/master/Foundation/NSURLError.swift
                        let providerError = ProviderError(code: error.code, failureReason: error.localizedDescription + " " + "\(error.code)")
                        observer.onError(providerError)
                    default:
                        observer.onError(error)
                    }
                }
            }

            return Disposables.create {
                cancellableToken.cancel()
            }
        }
    }

    public init(endpointClosure: @escaping EndpointClosure = LegoProvider.endpointClosure, manager: Manager = LegoManager.manager) {
        super.init(endpointClosure: endpointClosure, manager: manager)
    }
}



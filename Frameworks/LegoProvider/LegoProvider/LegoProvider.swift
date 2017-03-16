//
//  LegoProvider.swift
//  LegoProvider
//
//  Created by Limon on 16/03/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

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

class LegoProvider<Target: SugarTargetType>: MoyaProvider<Target> {

    static func endpointClosure(_ target: Target) -> Endpoint<Target> {
        let sampleResponseClosure = { return EndpointSampleResponse.networkResponse(200, target.sampleData) }
        let method = target.method
        let parameters = target.parameters
        let url = target.baseURL.appendingPathComponent(target.path).absoluteString
        return Endpoint<Target>(url: url, sampleResponseClosure: sampleResponseClosure, method: method, parameters: parameters, parameterEncoding: target.parameterEncoding, httpHeaderFields: target.headers)
    }

    init(endpointClosure: @escaping EndpointClosure = LegoProvider.endpointClosure, manager: Manager = LegoManager.manager) {
        super.init(endpointClosure: endpointClosure, manager: manager)
    }
}



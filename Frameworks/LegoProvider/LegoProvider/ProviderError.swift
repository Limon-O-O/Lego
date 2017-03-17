//
//  ProviderError.swift
//  LegoProvider
//
//  Created by Limon on 17/03/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation

public enum ProviderErrorCode: Int {
    case networkingError = 40000
    case invalidAuthToken = 40001
    case invalidUserAgent = 40002
    case invalidURL = 40004
    case nicknameExisted = 40008
    case abnormalAccount = 41001

    case unknown = 40404
    case noRepresentor = 40405
    case notSuccessfulHTTP = 40406
    case jsonSerializationFailed = 40407
    case generationObjectFailed = 40408

    public var value: Int {
        return self.rawValue
    }
}

public struct ProviderError: Swift.Error {

    public let code: ProviderErrorCode
    public let failureReason: String

    public init(code: Int, failureReason: String) {
        self.code = ProviderErrorCode(rawValue: code) ?? ProviderErrorCode.unknown
        self.failureReason = NSLocalizedString(failureReason, tableName: ServiceConfigure.tableName, bundle: ServiceConfigure.bundle, comment: "")
    }
}

extension ProviderError: CustomDebugStringConvertible {
    public var localizedDescription: String {
        return failureReason
    }
    public var debugDescription: String {
        return failureReason + "error code: \(code.value)"
    }
}

extension ProviderError {

    static var unknown: ProviderError {
        return ProviderError(code: ProviderErrorCode.unknown.rawValue, failureReason: "unknown")
    }

    static var jsonSerializationFailed: ProviderError {
        return ProviderError(code: ProviderErrorCode.jsonSerializationFailed.rawValue, failureReason: "jsonSerializationFailed")
    }

    static var notSuccessfulHTTP: ProviderError {
        return ProviderError(code: ProviderErrorCode.notSuccessfulHTTP.rawValue, failureReason: "notSuccessfulHTTP")
    }

    static var noRepresentor: ProviderError {
        return ProviderError(code: ProviderErrorCode.noRepresentor.rawValue, failureReason: "noRepresentor")
    }

    static var generationObjectFailed: ProviderError {
        return ProviderError(code: ProviderErrorCode.generationObjectFailed.rawValue, failureReason: "generationObjectFailed")
    }
}


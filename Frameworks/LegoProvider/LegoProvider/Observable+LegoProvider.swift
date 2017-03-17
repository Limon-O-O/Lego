//
//  Observable+LegoProvider.swift
//  Pods
//
//  Created by Limon on 17/03/2017.
//
//

import Foundation
import RxSwift
import Moya

public protocol Decodable {

    static func decoding(json: [String: Any]) -> Self?

    init?(json: [String: Any])
}

public extension Decodable {

    func decoding(json: [String: Any]) -> Self? {
        return Self(json: json)
    }

    static func decoding(json: [String: Any]) -> Self? {
        return Self(json: json)
    }
}

extension Observable where Element: Moya.Response {

    public func mapObject<T: Decodable>(type: T.Type) -> Observable<T> {

        return map { response in

            try response.validStatusCode()

            let mapedJSON = try response.mapJSON()

            guard let json = mapedJSON as? [String: Any] else {
                throw ProviderError.jsonSerializationFailed
            }

            guard let object = type.decoding(json: json) else {
                throw ProviderError.generationObjectFailed
            }

            return object
        }
    }

    public func mapObjects<T: Decodable>(type: T.Type) -> Observable<[T]> {

        return map { response in

            try response.validStatusCode()

            let mapedJSON = try response.mapJSON()

            guard let jsons = mapedJSON as? [[String: Any]] else {
                throw ProviderError.jsonSerializationFailed
            }

            return jsons.flatMap { type.decoding(json: $0) }
        }
    }
}

extension Moya.Response {

    func validStatusCode() throws {

        guard !((200...209) ~= statusCode) else { return }

        if let json = try mapJSON() as? [String: Any] {
            print("Got error message: \(json)")
            // json 的`错误信息和错误码`的 key，需自行修改，与服务器对应即可
            if let errorCode = json["error_code"] as? Int, let message = json["error_msg"] as? String {
                throw ProviderError(code: errorCode, failureReason: message)
            }
        }
        throw ProviderError.notSuccessfulHTTP
    }
}

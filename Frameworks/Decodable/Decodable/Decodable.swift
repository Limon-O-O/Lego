//
//  Decodable.swift
//  Decodable
//
//  Created by Limon on 19/03/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation

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

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

extension Decodable {

    public static func decoding(json: [String: Any]) -> Self? {
        return Self(json: json)
    }
}

//
//  SugarTargetType.swift
//  MoyaSugar
//
//  Created by Limon on 16/03/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Moya

public protocol SugarTargetType: TargetType {
    var headers: [String: String]? { get }
}

public extension SugarTargetType {
    public var headers: [String: String]? {
        return nil
    }
}

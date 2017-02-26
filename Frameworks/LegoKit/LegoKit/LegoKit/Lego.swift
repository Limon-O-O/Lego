//
//  Lego.swift
//  LegoKit
//
//  Created by Limon.F on 26/2/2017.
//  Copyright © 2017 Limon.F. All rights reserved.
//

import Foundation

public struct Lego<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol LegoProtocol {}

extension NSObject: LegoProtocol {}

extension LegoProtocol {
    public var lego: Lego<Self> {
        return Lego(self)
    }

    public static var lego: Lego<Self>.Type {
        return Lego.self
    }
}

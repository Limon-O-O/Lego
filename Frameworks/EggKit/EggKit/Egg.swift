//
//  Egg.swift
//  EggKit
//
//  Created by Limon on 20/02/2017.
//  Copyright © 2017 Limon.F. All rights reserved.
//

import Foundation

public struct Egg<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol EggProtocol {}

extension NSObject: EggProtocol {}

extension EggProtocol {
    public var egg: Egg<Self> {
        return Egg(self)
    }

    public static var egg: Egg<Self>.Type {
        return Egg.self
    }
}

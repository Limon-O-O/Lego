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

extension NSObject: EggProtocol {}

public protocol EggProtocol {
    associatedtype Base
    var egg: Base { get }
    static var egg: Base.Type { get }
}

extension EggProtocol {
    public var egg: Egg<Self> {
        return Egg(self)
    }

    public static var egg: Egg<Self>.Type {
        return Egg.self
    }
}

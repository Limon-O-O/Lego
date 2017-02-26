//
//  Tower.swift
//  CTMediator+Tower
//
//  Created by Limon.F on 18/2/2017.
//  Copyright © 2017 Limon.F. All rights reserved.
//

import Foundation

public struct Tower<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol TowerProtocol {}

extension NSObject: TowerProtocol {}

extension TowerProtocol {
    public var tower: Tower<Self> {
        return Tower(self)
    }

    public static var tower: Tower<Self>.Type {
        return Tower.self
    }
}

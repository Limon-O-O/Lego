//
//  Tower.swift
//  Tower
//
//  Created by Limon on 2017-02-27.

import Foundation
import Mediator

public struct Tower<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol TowerProtocol {}

extension Mediator: TowerProtocol {}

extension TowerProtocol {
    public var tower: Tower<Self> {
        return Tower(self)
    }

    public static var tower: Tower<Self>.Type {
        return Tower.self
    }
}

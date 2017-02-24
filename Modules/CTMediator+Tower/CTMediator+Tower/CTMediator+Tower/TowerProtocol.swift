//
//  Tower.swift
//  Tower
//
//  Created by Limon on 2017-02-24.

import Foundation

public struct Tower<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

extension NSObject: TowerProtocol {}

public protocol TowerProtocol {
    associatedtype Base
    var tower: Base { get }
    static var Tower: Base.Type { get }
}

extension TowerProtocol {
    public var tower: Tower<Self> {
        return Tower(self)
    }

    public static var tower: Tower<Self>.Type {
        return Tower.self
    }
}

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

extension NSObject: TowerProtocol {}

public protocol TowerProtocol {
    associatedtype Base
    var tower: Base { get }
    static var tower: Base.Type { get }
}

extension TowerProtocol {
    public var tower: Tower<Self> {
        return Tower(self)
    }

    public static var tower: Tower<Self>.Type {
        return Tower.self
    }
}

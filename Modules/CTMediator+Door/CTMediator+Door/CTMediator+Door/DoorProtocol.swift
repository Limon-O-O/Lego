//
//  Door.swift
//  Door
//
//  Created by Limon on 2017-02-24.

import Foundation

public struct Door<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

extension NSObject: DoorProtocol {}

public protocol DoorProtocol {
    associatedtype Base
    var door: Base { get }
    static var Door: Base.Type { get }
}

extension DoorProtocol {
    public var door: Door<Self> {
        return Door(self)
    }

    public static var door: Door<Self>.Type {
        return Door.self
    }
}

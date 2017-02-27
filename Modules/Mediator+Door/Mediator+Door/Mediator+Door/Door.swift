//
//  Door.swift
//  Door
//
//  Created by Limon on 2017-02-27.

import Foundation
import Mediator

public struct Door<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol DoorProtocol {}

extension Mediator: DoorProtocol {}

extension DoorProtocol {
    public var door: Door<Self> {
        return Door(self)
    }

    public static var door: Door<Self>.Type {
        return Door.self
    }
}

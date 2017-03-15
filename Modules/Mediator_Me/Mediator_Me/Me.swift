//
//  Me.swift
//  Me
//
//  Created by Limon on 2017-03-15.

import Foundation
import Mediator

public struct Me<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol MeProtocol {}

extension Mediator: MeProtocol {}

extension MeProtocol {
    public var me: Me<Self> {
        return Me(self)
    }

    public static var me: Me<Self>.Type {
        return Me.self
    }
}

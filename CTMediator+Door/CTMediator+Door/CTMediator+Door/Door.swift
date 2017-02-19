//
//  Door.swift
//  CTMediator+Door
//
//  Created by Limon.F on 19/2/2017.
//  Copyright © 2017 Limon.F. All rights reserved.
//

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
    static var door: Base.Type { get }
}

extension DoorProtocol {
    public var door: Door<Self> {
        return Door(self)
    }

    public static var door: Door<Self>.Type {
        return Door.self
    }
}

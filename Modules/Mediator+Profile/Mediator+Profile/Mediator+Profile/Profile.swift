//
//  Profile.swift
//  Profile
//
//  Created by Limon on 2017-03-01.

import Foundation
import Mediator

public struct Profile<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol ProfileProtocol {}

extension Mediator: ProfileProtocol {}

extension ProfileProtocol {
    public var profile: Profile<Self> {
        return Profile(self)
    }

    public static var profile: Profile<Self>.Type {
        return Profile.self
    }
}

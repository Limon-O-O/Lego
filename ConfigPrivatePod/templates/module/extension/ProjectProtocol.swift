//
//  __ProjectName__.swift
//  __ProjectName__
//
//  Created by __Author__ on __Time__.

import Foundation

public struct __ProjectName__<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

extension NSObject: __ProjectName__Protocol {}

public protocol __ProjectName__Protocol {
    associatedtype Base
    var __projectName__: Base { get }
    static var __ProjectName__: Base.Type { get }
}

extension __ProjectName__Protocol {
    public var __projectName__: __ProjectName__<Self> {
        return __ProjectName__(self)
    }

    public static var __projectName__: __ProjectName__<Self>.Type {
        return __ProjectName__.self
    }
}

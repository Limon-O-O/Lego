//
//  String+Egg.swift
//  EggKit
//
//  Created by Limon on 20/02/2017.
//  Copyright © 2017 Limon.F. All rights reserved.
//

import Foundation

public extension StringProxy {

    enum TrimmingType {
        case whitespace
        case whitespaceAndNewline
    }

    public func trimming(_ trimmingType: TrimmingType) -> String {
        switch trimmingType {
        case .whitespace:
            return base.trimmingCharacters(in: .whitespaces)
        case .whitespaceAndNewline:
            return base.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }

    public var encodingString: String? {
        return base.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }

    public var localized: String {
        return NSLocalizedString(base, comment: "")
    }
}

public struct StringProxy {

    public let base: String

    init(_ base: String) {
        self.base = base
    }
}

extension String {

    public var egg: StringProxy {
        return StringProxy(self)
    }
    
    public static var egg: StringProxy.Type {
        return StringProxy.self
    }
}


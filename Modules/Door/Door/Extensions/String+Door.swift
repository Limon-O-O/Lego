//
//  String+Door.swift
//  Door
//
//  Created by Limon on 21/02/2017.
//  Copyright © 2017 Limon.F. All rights reserved.
//

import EggKit

extension StringProxy {

    var localized: String {
        return NSLocalizedString(base, tableName: Configure.tableName, bundle: Configure.bundle, comment: "")
    }
}

struct StringProxy {

    public let base: String

    init(_ base: String) {
        self.base = base
    }
}

extension String {

    var egg: StringProxy {
        return StringProxy(self)
    }

    static var egg: StringProxy.Type {
        return StringProxy.self
    }
}

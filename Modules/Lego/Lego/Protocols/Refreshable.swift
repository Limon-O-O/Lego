//
//  Refreshable.swift
//  Lego
//
//  Created by Limon on 28/02/2017.
//  Copyright © 2017 Limon.F. All rights reserved.
//

import Foundation

import Foundation

protocol Refreshable {

    func refresh()

    var isAtTop: Bool { get }

    func scrollsToTopIfNeeded(otherwise: (() -> Void)?)
}

extension Refreshable {

    var isAtTop: Bool {
        return true
    }

    func scrollsToTopIfNeeded(otherwise: (() -> Void)?) {}
}

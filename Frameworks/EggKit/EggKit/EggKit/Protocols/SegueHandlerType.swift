//
//  SegueHandlerType.swift
//  EggKit
//
//  Created by Limon on 20/02/2017.
//  Copyright © 2017 Limon.F. All rights reserved.
//

import UIKit

public protocol SegueHandlerType {
    associatedtype SegueIdentifier: RawRepresentable
}

public extension SegueHandlerType where Self: UIViewController, SegueIdentifier.RawValue == String {

    public func performSegue(withIdentifier identifier: SegueIdentifier, sender: Any?) {

        if let navigationController = navigationController {
            guard navigationController.topViewController == self else {
                return
            }
        }

        DispatchQueue.main.async {
            self.performSegue(withIdentifier: identifier.rawValue, sender: sender)
        }
    }

    public func segueIdentifier(for segue: UIStoryboardSegue) -> SegueIdentifier {
        guard
            let identifier = segue.identifier,
            let segueIdentifier = SegueIdentifier(rawValue: identifier) else {
                fatalError("INVALID SEGUE IDENTIFIER \(segue.identifier)")
        }
        return segueIdentifier
    }
}


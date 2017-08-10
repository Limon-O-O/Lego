//
//  UIImage+Lego.swift
//  LegoKit
//
//  Created by Limon.F on 26/2/2017.
//  Copyright © 2017 Limon.F. All rights reserved.
//

import UIKit

extension Lego where Base: UIImage {

    static var headline: UIImage? {
        let classBundle = Bundle(for: Empty.self)
        return UIImage(named: "headline", in: classBundle, compatibleWith: nil)
    }
}


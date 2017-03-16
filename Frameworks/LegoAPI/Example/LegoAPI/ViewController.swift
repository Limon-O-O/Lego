//
//  ViewController.swift
//  LegoAPI
//
//  Created by Limon-O-O on 03/16/2017.
//  Copyright (c) 2017 Limon-O-O. All rights reserved.
//

import UIKit
import RxSwift
import LegoProvider

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let provider = LegoProvider<UserAPI>()

        provider.request(.login([:])) { (_) in

        }
//        provider.request(.login([:])).subscribe { event in
//            switch event {
//            case let .next(response):
//                image = UIImage(data: response.data)
//            case let .error(error):
//                print(error)
//            default:
//                break
//            }
//        }
    }

}


//
//  FirstViewController.swift
//  Lego
//
//  Created by Limon.F on 19/2/2017.
//  Copyright © 2017 Limon.F. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FirstViewController: UIViewController {

    private let disposeBag = DisposeBag()

    @IBOutlet private weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.rx.tap
            .throttle(0.3, scheduler: MainScheduler.instance)
            .subscribe(onNext: { _ in
                (UIApplication.shared.delegate as? AppDelegate)?.startDoorStory()
            })
            .addDisposableTo(disposeBag)
    }

    deinit {
        print("FirstViewController Deinit")
    }
}


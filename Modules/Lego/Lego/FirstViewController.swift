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
import Mediator
import Mediator_Profile

class FirstViewController: UIViewController {

    private let disposeBag = DisposeBag()

    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var profileButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.rx.tap
            .throttle(0.3, scheduler: MainScheduler.instance)
            .subscribe(onNext: { _ in
                (UIApplication.shared.delegate as? AppDelegate)?.startDoorStory()
            })
            .addDisposableTo(disposeBag)

        profileButton.rx.tap
            .throttle(0.3, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in

                let action = {
                    let vc = Mediator.shared.profile.profileViewController { info in
                    }
                    self?.navigationController?.pushViewController(vc!, animated: true)
                }

                let didLogin = { return false }() // LegoUserDefaults.didLogin

                if didLogin {
                    action()
                } else {
                    let callbackAction: ([String: Any]) -> Void = { [weak self] info in
                        guard let _ = info["userID"] as? Int else { return }
                        self?.dismiss(animated: true, completion: nil)
                        action()
                    }
                    let welcomeViewController = Mediator.shared.door.welcomeViewController { info in callbackAction(info) }
                    guard let controller = welcomeViewController else { return }
                    self?.present(controller, animated: true, completion: nil)
                }

            })
            .addDisposableTo(disposeBag)
    }

    deinit {
        print("FirstViewController Deinit")
    }
}


//
//  LoginViewController.swift
//  Door
//
//  Created by Limon.F on 19/2/2017.
//  Copyright © 2017 Limon.F. All rights reserved.
//

import UIKit
import LegoKit
import RxSwift
import RxCocoa

class LoginViewController: BaseViewController {

    var innateParams: [String: Any] = [:]

    @IBOutlet private weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"

        loginButton.rx.tap
            .throttle(0.3, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in

                DoorUserDefaults.accessToken = "002dS5ZGOoM5BCd78614ac1dJnIUWD"
                DoorUserDefaults.userID = 007

                let alertController = UIAlertController(title: nil, message: "登录成功", preferredStyle: .alert)
                let action: UIAlertAction = UIAlertAction(title: "确定", style: .default) { _ in

                    let deliverParams: [String: Any] = [
                        "accessToken": DoorUserDefaults.accessToken,
                        "userID": DoorUserDefaults.userID
                    ]

                    // TODO: 如何返回主项目？闭包？还是通过 Mediator？
                    (self?.innateParams["callbackAction"] as? ([String: Any]) -> Void)?(deliverParams)
                }

                alertController.addAction(action)
                self?.present(alertController, animated: true, completion: nil)
            })
            .addDisposableTo(disposeBag)
    }

    deinit {
        print("LoginViewController Deinit")
    }
}

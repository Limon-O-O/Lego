//
//  TowerViewController.swift
//  Tower
//
//  Created by Limon.F on 18/2/2017.
//  Copyright © 2017 Limon.F. All rights reserved.
//

import UIKit
import Mediator
import LegoContext
import Mediator_Door

class TowerViewController: UIViewController {

    var innateParams: [String: Any] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tower"
        view.backgroundColor = (innateParams["color"] as? UIColor) ?? UIColor.white
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        (innateParams["callbackAction"] as? ([String: Any]) -> Void)?(["price": "8.8"])
    }

    @IBAction private func niceButtonAction(_ sender: UIButton) {

        let action = { [weak self] in
            let alertController = UIAlertController(title: nil, message: "点赞成功", preferredStyle: .alert)
            let action: UIAlertAction = UIAlertAction(title: "确定", style: .default) { _ in }
            alertController.addAction(action)
            self?.present(alertController, animated: true, completion: nil)
        }

        // 需要知道是否已经登录了，问 LegoContext 是否已经登录了

        if LegoContext.didLogin {
            action()

        } else {

            // 这里也要登录呀，怎么办？import Mediator+Door 进来
            Mediator.shared.door.presentWelcomeViewController() { _ in

                guard LegoContext.didLogin else { return }
                // 登录成功回调，直接再出发点赞，不需要再用户手动点一次
                action()
            }
        }
    }
}

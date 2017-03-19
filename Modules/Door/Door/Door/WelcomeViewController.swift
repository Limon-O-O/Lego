//
//  WelcomeViewController.swift
//  Door
//
//  Created by Limon.F on 19/2/2017.
//  Copyright © 2017 Limon.F. All rights reserved.
//

import UIKit
import EggKit
import RxSwift
import MonkeyKing

class WelcomeViewController: UIViewController {

    var innateParams: [String: Any] = [:]

    @IBOutlet private weak var loginButton: UIButton!

    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet private weak var weiboButton: UIButton!
    @IBOutlet private weak var qqButton: UIButton!
    @IBOutlet private weak var wechatButton: UIButton!
    @IBOutlet private weak var phoneButton: UIButton!
    @IBOutlet private weak var loginWayLabel: UILabel!
    fileprivate var showStatusBar = false

    fileprivate let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Welcome"

        loginWayLabel.text = "select_login_way".egg.localized
        weiboButton.setTitle("button.weibo_login".egg.localized, for: .normal)
        qqButton.setTitle("button.qq_login".egg.localized, for: .normal)
        wechatButton.setTitle("button.wechat_login".egg.localized, for: .normal)
        phoneButton.setTitle("button.phone_login".egg.localized, for: .normal)
        registerButton.setTitle("button.register_by_phone".egg.localized, for: .normal)

        loginButton.rx.tap
            .throttle(0.3, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in

                let accessToken = "002dS5ZGOoM5BCd78614ac1dJnIUWD"
                let userID: Int = 007

                DoorUserDefaults.accessToken = accessToken
                DoorUserDefaults.userID = userID

                let alertController = UIAlertController(title: nil, message: "登录成功", preferredStyle: .alert)
                let action: UIAlertAction = UIAlertAction(title: "确定", style: .default) { _ in

                    let deliverParams: [String: Any] = [
                        "accessToken": accessToken,
                        "userID": userID
                    ]

                    // 通过闭包回调出去，这样不用依赖 Main Project
                    (self?.innateParams["callbackAction"] as? ([String: Any]) -> Void)?(deliverParams)
                }

                alertController.addAction(action)
                self?.present(alertController, animated: true, completion: nil)
            })
            .addDisposableTo(disposeBag)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let navigationBarHidden = (innateParams["navigationBarHidden"] as? Bool) ?? true
        showStatusBar = !navigationBarHidden
        navigationController?.setNavigationBarHidden(navigationBarHidden, animated: true)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        UIView.animate(withDuration: 0.2) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }

    override var prefersStatusBarHidden : Bool {
        return !showStatusBar
    }

    deinit {
        print("WelcomeViewController Deinit")
    }
}

// MARK: - Segue

extension WelcomeViewController: SegueHandlerType {

    enum SegueIdentifier: String {
        case showLogin
        case showPhoneNumberPicker
    }

    @IBAction private func register(_ sender: UIButton) {
        performSegue(withIdentifier: .showPhoneNumberPicker, sender: nil)
    }

    @IBAction private func login(_ sender: UIButton) {
        performSegue(withIdentifier: .showLogin, sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        showStatusBar = true
        setNeedsStatusBarAppearanceUpdate()

        switch segueIdentifier(for: segue) {
        case .showLogin:
            let vc = segue.destination as? LoginViewController
            vc?.innateParams = innateParams

        case .showPhoneNumberPicker:
            let vc = segue.destination as? PhoneNumberPickerViewController
            vc?.innateParams = innateParams
        }
    }
}

// MARK: - Actions

extension WelcomeViewController {

    private func login(platform: LoginPlatform, token: String, openID: String) {

        UserProvider.request(.login(["": ""]))
            .mapObject(type: LoginUser.self)
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { success in

            }, onError: { error in

            })
            .addDisposableTo(disposeBag)
    }

    @IBAction private func qqLogin(_ sender: UIButton) {

        let account = MonkeyKing.Account.qq(appID: Configure.Account.QQ.appID)
        MonkeyKing.registerAccount(account)

        MonkeyKing.oauth(for: .qq) { [weak self] info, response, error in

            guard
                let unwrappedInfo = info,
                let token = unwrappedInfo["access_token"] as? String,
                let openID = unwrappedInfo["openid"] as? String else {
                    return
            }

            self?.login(platform: .qq, token: token, openID: openID)
        }
    }

    @IBAction private func weiboLogin(_ sender: UIButton) {

        let account = MonkeyKing.Account.weibo(appID: Configure.Account.Weibo.appID, appKey: Configure.Account.Weibo.appKey, redirectURL: Configure.Account.Weibo.redirectURL)
        MonkeyKing.registerAccount(account)

        MonkeyKing.oauth(for: .weibo) { [weak self] info, response, error in

            // App or Web: token & userID
            guard
                let unwrappedInfo = info,
                let token = (unwrappedInfo["access_token"] as? String) ?? (unwrappedInfo["accessToken"] as? String),
                let userID = (unwrappedInfo["uid"] as? String) ?? (unwrappedInfo["userID"] as? String) else {
                    return
            }

            self?.login(platform: .weibo, token: token, openID: userID)
        }
    }

    @IBAction private func weChatLogin(_ sender: UIButton) {

        let account = MonkeyKing.Account.weChat(appID: Configure.Account.Wechat.appID, appKey: Configure.Account.Wechat.appKey)
        MonkeyKing.registerAccount(account)

        MonkeyKing.oauth(for: .weChat) { [weak self] oauthInfo, response, error in

            guard
                let token = oauthInfo?["access_token"] as? String,
                let userID = oauthInfo?["openid"] as? String else {
                    return
            }
            
            self?.login(platform: .weChat, token: token, openID: userID)
        }
    }
}

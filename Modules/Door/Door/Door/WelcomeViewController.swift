//
//  WelcomeViewController.swift
//  Door
//
//  Created by Limon.F on 19/2/2017.
//  Copyright © 2017 Limon.F. All rights reserved.
//

import UIKit
import RxSwift
import MonkeyKing
// import Networking

class WelcomeViewController: UIViewController {

    @IBOutlet fileprivate weak var loginButton: UIButton!

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var weiboButton: UIButton!
    @IBOutlet weak var qqButton: UIButton!
    @IBOutlet weak var wechatButton: UIButton!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var loginWayLabel: UILabel!
    fileprivate var showStatusBar = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        loginWayLabel.text = "select_login_way".egg.localized
        weiboButton.setTitle("button.weibo_login".egg.localized, for: .normal)
        qqButton.setTitle("button.qq_login".egg.localized, for: .normal)
        wechatButton.setTitle("button.wechat_login".egg.localized, for: .normal)
        phoneButton.setTitle("button.phone_login".egg.localized, for: .normal)
        registerButton.setTitle("button.register_by_phone".egg.localized, for: .normal)

        if !CrispUserDefaults.didRequestNetworking {

            CrispUserDefaults.didRequestNetworking = true

            EggAlert.confirmOrCancel(title: nil, message: "prompt.open_network_permission.description".egg.localized, confirmTitle: "prompt.open_now.action".egg.localized, cancelTitle: "prompt.cancel.action".egg.localized, inViewController: self, withConfirmAction: { [weak self] in

                guard let `self` = self else { return }

                NetworkingService.launch()
                    .subscribe(onNext: { res in
                    })
                    .addDisposableTo(self.disposeBag)

                }, cancelAction: {})
        }

        showStatusBar = false

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
        case showRegisterPickMobile
        case showLoginByMobile
    }

    @IBAction private func register(_ sender: UIButton) {
        performSegue(withIdentifier: .showRegisterPickMobile, sender: nil)
    }

    @IBAction private func login(_ sender: UIButton) {
        performSegue(withIdentifier: .showLoginByMobile, sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        showStatusBar = true
        setNeedsStatusBarAppearanceUpdate()
    }

    private func login(platform: CrispUserDefaults.LoginPlatform, token: String, openID: String) {

        EggHUD.showActivityIndicator()

        NetworkingService.login(platform: platform.rawValue, token: token, openID: openID).success { userJSON in

            guard let loginUser = LoginUser(json: userJSON) else { return }

            UserService.shared.behaviorsAfterLogin(user: loginUser, completionHandler: {
                EggHUD.hideActivityIndicator()
                CrispUserDefaults.loginPlatform = platform

                if loginUser.registerRequired {
                    (UIApplication.shared.delegate as? AppDelegate)?.startPickNameStory()
                } else if loginUser.recommendationsRequired {
                    (UIApplication.shared.delegate as? AppDelegate)?.startRecommendationsStory()
                } else {
                    (UIApplication.shared.delegate as? AppDelegate)?.startMainStory()
                }
            })

            }.failure { [weak self] error, isCancelled in

                EggHUD.hideActivityIndicator() {
                    if let error = error, !isCancelled {
                        if error.code == NetworkingErrorCode.networkingError {
                            EggAlert.confirmOrCancel(title: nil, message: "prompt.open_network_permission.description".egg.localized, confirmTitle: "prompt.go_to_open_now.action".egg.localized, cancelTitle: "prompt.cancel.action".egg.localized, inViewController: self, withConfirmAction: {
                                if let url = URL(string: UIApplicationOpenSettingsURLString) {
                                    UIApplication.shared.openURL(url)
                                }
                            }, cancelAction: {})

                        } else {
                            EggAlert.alertSorry(message: error.failureReason, inViewController: self)
                        }
                    }
                }
        }
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

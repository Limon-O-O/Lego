//
//  BaseViewController.swift
//  LegoKit
//
//  Created by Limon.F on 23/2/2017.
//  Copyright © 2017 Limon.F. All rights reserved.
//

import UIKit
import RxSwift

open class BaseViewController: UIViewController {

    open let disposeBag = DisposeBag()

    override open func viewDidLoad() {
        super.viewDidLoad()
    }

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: true)

        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    override open var prefersStatusBarHidden: Bool {
        return false
    }

    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    override open var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
}

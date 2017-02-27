//
//  NavigationController.swift
//  Pods
//
//  Created by Limon.F on 26/2/2017.
//
//

import UIKit
import LegoKit

open class NavigationController: UINavigationController {

    override open func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.isTranslucent = false

        setHeadline(with: UIImage.lego.headline)

        // 颜色
        navigationBar.barTintColor = UIColor.white
        navigationBar.tintColor = UIColor.lego.tint

        let textAttributes: [String: Any] = [
            NSForegroundColorAttributeName: UIColor.lego.tint
        ]
        navigationBar.titleTextAttributes = textAttributes

        interactivePopGestureRecognizer?.delegate = self
        delegate = self

        // 去掉 `返回` 二字
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    override open var childViewControllerForStatusBarStyle : UIViewController? {
        return topViewController
    }

    override open var childViewControllerForStatusBarHidden : UIViewController? {
        return topViewController
    }

    private func setHeadline(with image: UIImage?) {
        navigationBar.setBackgroundImage(UIImage(), for: .top, barMetrics: .default)
        navigationBar.shadowImage = image ?? UIImage() // UIImage() 即隐藏 headline
    }

}

extension NavigationController: UIGestureRecognizerDelegate, UINavigationControllerDelegate {

    override open func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if animated {
            interactivePopGestureRecognizer?.isEnabled = false
        }

        if viewControllers.count < 2 || self.visibleViewController == self.viewControllers.first {
            hidesBottomBarWhenPushed = true
        } else {
            hidesBottomBarWhenPushed = false
        }

        super.pushViewController(viewController, animated: animated)
    }

    override open func popToRootViewController(animated: Bool) -> [UIViewController]? {
        if animated {
            interactivePopGestureRecognizer?.isEnabled = false
        }

        return super.popToRootViewController(animated: animated)
    }

    override open func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        if animated {
            interactivePopGestureRecognizer?.isEnabled = false
        }

        return super.popToViewController(viewController, animated: animated)
    }

    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        interactivePopGestureRecognizer?.isEnabled = true
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == interactivePopGestureRecognizer {
            if self.viewControllers.count < 2 || self.visibleViewController == self.viewControllers.first {
                return false
            }
        }
        
        return true
    }
}





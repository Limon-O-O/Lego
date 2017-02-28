//
//  TabBarController.swift
//  Lego
//
//  Created by Limon on 28/02/2017.
//  Copyright © 2017 Limon.F. All rights reserved.
//

import UIKit
import LegoKit

final class TabBarController: UITabBarController {

    enum Tab: Int {
        case home
        case discover
        case me

        var title: String {
            switch self {
            case .home:
                return "Home".egg.localized
            case .discover:
                return "Discover".egg.localized
            case .me:
                return "Me".egg.localized
            }
        }

        var image: UIImage? {
            switch self {
            case .home:
                return UIImage(named: "first")
            case .discover:
                return UIImage(named: "second")
            case .me:
                return UIImage(named: "icon_me")
            }
        }
    }

    var selectedTab: Tab = .home {
        didSet {
            self.selectedIndex = selectedTab.rawValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self

        tabBar.tintColor = UIColor.lego.blue

        view.layoutIfNeeded() // 解决使用 Reference 连接 NavigationController，就算给 tabBar.tiem.image 设置了图片也不出现的问题，比如 Me 模块
        configureItem()
    }

    private func configureItem() {
        guard let items = tabBar.items else { return }
        for (index, item) in items.enumerated() {
            if let tab = Tab(rawValue: index) {
                item.image = tab.image?.withRenderingMode(.alwaysOriginal)
                item.selectedImage = tab.image
                item.title = tab.title
            }
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension TabBarController: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

        guard let tab = Tab(rawValue: selectedIndex),
            let nvc = viewController as? UINavigationController
            else {
                return
        }

        if tab != selectedTab {
            selectedTab = tab
            return
        }

        if let vc = nvc.topViewController as? Refreshable {
            if vc.isAtTop {
                vc.refresh()
            } else {
                vc.scrollsToTopIfNeeded(otherwise: nil)
            }
        }
    }
}

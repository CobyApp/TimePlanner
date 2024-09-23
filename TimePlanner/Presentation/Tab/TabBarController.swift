//
//  TabBarController.swift
//  TimePlanner
//
//  Created by Coby on 9/23/24.
//

import UIKit

final class TabBarController: UITabBarController {
    private lazy var vc1 = UINavigationController(rootViewController: self.mainViewController)
    private lazy var vc2 = UINavigationController(rootViewController: self.mainViewController)
    private lazy var vc3 = UINavigationController(rootViewController: self.mainViewController)
    private lazy var vc4 = UINavigationController(rootViewController: self.mainViewController)

    override func viewDidLoad() {
        super.viewDidLoad()

        vc1.tabBarItem.image = UIImage.Button.person
            .resize(to: CGSize(width: 20, height: 20))
        vc1.tabBarItem.title = "메인"

        vc2.tabBarItem.image = UIImage.Button.person
            .resize(to: CGSize(width: 18, height: 18))
        vc2.tabBarItem.title = "메모"

        vc3.tabBarItem.image = UIImage.Button.person
            .resize(to: CGSize(width: 20, height: 20))
        vc3.tabBarItem.title = "디데이"

        vc4.tabBarItem.image = UIImage.Button.person
            .resize(to: CGSize(width: 20, height: 20))
        vc4.tabBarItem.title = "정보"

        tabBar.tintColor = .labelNormal
        tabBar.backgroundColor = .backgroundNormalNormal
        setViewControllers([vc1, vc2, vc3, vc4], animated: true)

        let tabBarAppearance: UITabBarAppearance = .init()
        tabBarAppearance.configureWithDefaultBackground()
        tabBarAppearance.backgroundColor = .backgroundNormalNormal
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension TabBarController {
    
    var mainViewController: MainViewController {
        let viewController = MainViewController()
        return viewController
    }
}

//
//  TabBarController.swift
//  TimePlanner
//
//  Created by Coby on 9/23/24.
//

import UIKit

final class TabBarController: UITabBarController {
    
    private lazy var vc1: UINavigationController = {
        let navController = UINavigationController()
        let mainCoordinator = MainCoordinator(navigationController: navController)
        let mainViewModel = MainViewModel(coordinator: mainCoordinator)
        let mainViewController = MainViewController(viewModel: mainViewModel)
        navController.viewControllers = [mainViewController]
        
        navController.tabBarItem.image = UIImage.Button.home.resize(to: CGSize(width: 20, height: 20))
        navController.tabBarItem.title = "메인"
        
        return navController
    }()
    
    private lazy var vc2: UINavigationController = {
        let navController = UINavigationController()
        let noteCoordinator = NoteCoordinator(navigationController: navController)
        let noteViewModel = NoteViewModel(coordinator: noteCoordinator)
        let noteViewController = NoteViewController(viewModel: noteViewModel)
        navController.viewControllers = [noteViewController]
        
        navController.tabBarItem.image = UIImage.Button.note.resize(to: CGSize(width: 20, height: 20))
        navController.tabBarItem.title = "노트"
        
        return navController
    }()
    
    private lazy var vc3: UINavigationController = {
        let navController = UINavigationController()
        let dDayCoordinator = DDayCoordinator(navigationController: navController)
        let dDayViewModel = DDayViewModel(coordinator: dDayCoordinator)
        let dDayViewController = DDayViewController(viewModel: dDayViewModel)
        navController.viewControllers = [dDayViewController]
        
        navController.tabBarItem.image = UIImage.Button.calendarClock.resize(to: CGSize(width: 20, height: 20))
        navController.tabBarItem.title = "디데이"
        
        return navController
    }()
    
    private lazy var vc4: UINavigationController = {
        let navController = UINavigationController()
        let infoCoordinator = InfoCoordinator(navigationController: navController)
        let infoViewModel = InfoViewModel(coordinator: infoCoordinator)
        let infoViewController = InfoViewController(viewModel: infoViewModel)
        navController.viewControllers = [infoViewController]
        
        navController.tabBarItem.image = UIImage.Button.person.resize(to: CGSize(width: 20, height: 20))
        navController.tabBarItem.title = "정보"
        
        return navController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = .labelNormal
        self.tabBar.backgroundColor = .backgroundNormalNormal
        
        // 모든 ViewControllers를 설정
        self.setViewControllers([vc1, vc2, vc3, vc4], animated: true)
        
        let tabBarAppearance: UITabBarAppearance = .init()
        tabBarAppearance.configureWithDefaultBackground()
        tabBarAppearance.backgroundColor = .backgroundNormalNormal
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
}

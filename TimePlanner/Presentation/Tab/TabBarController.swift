//
//  TabBarController.swift
//  TimePlanner
//
//  Created by Coby on 9/23/24.
//

import UIKit

final class TabBarController: UITabBarController {
    
    private lazy var vc1: UINavigationController = {
        let navigationController = UINavigationController()
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        let mainViewModel = MainViewModel(coordinator: mainCoordinator)
        let mainViewController = MainViewController(viewModel: mainViewModel)
        navigationController.viewControllers = [mainViewController]
        
        navigationController.tabBarItem.image = UIImage.Button.home.resize(to: CGSize(width: 20, height: 20))
        navigationController.tabBarItem.title = "할일"
        
        return navigationController
    }()
    
    private lazy var vc2: UINavigationController = {
        let navigationController = UINavigationController()
        let repository = NoteRepositoryImpl()
        let usecase = NoteUsecaseImpl(repository: repository)
        let coordinator = NoteCoordinator(navigationController: navigationController)
        let viewModel = NoteViewModel(usecase: usecase, coordinator: coordinator)
        let viewController = NoteViewController(viewModel: viewModel)
        navigationController.viewControllers = [viewController]
        
        navigationController.tabBarItem.image = UIImage.Button.note.resize(to: CGSize(width: 20, height: 20))
        navigationController.tabBarItem.title = "노트"
        
        return navigationController
    }()
    
    private lazy var vc3: UINavigationController = {
        let navigationController = UINavigationController()
        let dDayCoordinator = DDayCoordinator(navigationController: navigationController)
        let dDayViewModel = DDayViewModel(coordinator: dDayCoordinator)
        let dDayViewController = DDayViewController(viewModel: dDayViewModel)
        navigationController.viewControllers = [dDayViewController]
        
        navigationController.tabBarItem.image = UIImage.Button.calendarClock.resize(to: CGSize(width: 20, height: 20))
        navigationController.tabBarItem.title = "디데이"
        
        return navigationController
    }()
    
    private lazy var vc4: UINavigationController = {
        let navigationController = UINavigationController()
        let infoCoordinator = InfoCoordinator(navigationController: navigationController)
        let infoViewModel = InfoViewModel(coordinator: infoCoordinator)
        let infoViewController = InfoViewController(viewModel: infoViewModel)
        navigationController.viewControllers = [infoViewController]
        
        navigationController.tabBarItem.image = UIImage.Button.person.resize(to: CGSize(width: 20, height: 20))
        navigationController.tabBarItem.title = "정보"
        
        return navigationController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = .mainColor
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

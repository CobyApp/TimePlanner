//
//  MainCoordinator.swift
//  TimePlanner
//
//  Created by Coby on 10/5/24.
//

import UIKit

final class MainCoordinator: NSObject {
    
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    func presentCategoryRegister() {
        guard let navigationController = self.navigationController else { return }
        let coordinator = CategoryRegisterCoordinator(navigationController: navigationController)
        let viewModel = CategoryRegisterViewModel(coordinator: coordinator)
        let viewController = CategoryRegisterViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func presentCategoryManagement() {
        guard let navigationController = self.navigationController else { return }
        let coordinator = CategoryManagementCoordinator(navigationController: navigationController)
        let viewModel = CategoryManagementViewModel(coordinator: coordinator)
        let viewController = CategoryManagementViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
}

//
//  CategoryManagementCoordinator.swift
//  TimePlanner
//
//  Created by Coby on 10/5/24.
//

import UIKit

final class CategoryManagementCoordinator: NSObject {
    
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
}

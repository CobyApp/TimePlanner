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
    
    func dismiss() {
        guard let navigationController = navigationController else { return }
        navigationController.popViewController(animated: true)
    }
    
    func presentCategoryRegister(category: CategoryModel?) {
        guard let navigationController = self.navigationController else { return }
        let repository = ToDoRepositoryImpl()
        let usecase = ToDoUsecaseImpl(repository: repository)
        let coordinator = CategoryRegisterCoordinator(navigationController: navigationController)
        let viewModel = CategoryRegisterViewModel(usecase: usecase, coordinator: coordinator, category: category)
        let viewController = CategoryRegisterViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
}

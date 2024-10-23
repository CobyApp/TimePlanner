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
        let repository = ToDoRepositoryImpl()
        let usecase = ToDoUsecaseImpl(repository: repository)
        let coordinator = CategoryRegisterCoordinator(navigationController: navigationController)
        let viewModel = CategoryRegisterViewModel(usecase: usecase, coordinator: coordinator)
        let viewController = CategoryRegisterViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func presentCategoryManagement() {
        guard let navigationController = self.navigationController else { return }
        let repository = ToDoRepositoryImpl()
        let usecase = ToDoUsecaseImpl(repository: repository)
        let coordinator = CategoryManagementCoordinator(navigationController: navigationController)
        let viewModel = CategoryManagementViewModel(usecase: usecase, coordinator: coordinator)
        let viewController = CategoryManagementViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func presentToDoItemRegister(categoryId: String) {
        guard let navigationController = self.navigationController else { return }
        let repository = ToDoRepositoryImpl()
        let usecase = ToDoUsecaseImpl(repository: repository)
        let coordinator = ToDoItemRegisterCoordinator(navigationController: navigationController)
        let viewModel = ToDoItemRegisterViewModel(usecase: usecase, coordinator: coordinator, categoryId: categoryId)
        let viewController = ToDoItemRegisterViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func presentToDoItemRegister(categoryId: String, toDoItem: ToDoItemModel) {
        guard let navigationController = self.navigationController else { return }
        let repository = ToDoRepositoryImpl()
        let usecase = ToDoUsecaseImpl(repository: repository)
        let coordinator = ToDoItemRegisterCoordinator(navigationController: navigationController)
        let viewModel = ToDoItemRegisterViewModel(usecase: usecase, coordinator: coordinator, categoryId: categoryId, toDoItem: toDoItem)
        let viewController = ToDoItemRegisterViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
}

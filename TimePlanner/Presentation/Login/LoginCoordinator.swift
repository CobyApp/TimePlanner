//
//  LoginCoordinator.swift
//  TimePlanner
//
//  Created by Coby on 10/14/24.
//

import UIKit

final class LoginCoordinator: NSObject {
    
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    func presentSign() {
        guard let navigationController = self.navigationController else { return }
        let repository = SignRepositoryImpl()
        let usecase = SignUsecaseImpl(repository: repository)
        let coordinator = SignCoordinator(navigationController: navigationController)
        let viewModel = SignViewModel(usecase: usecase, coordinator: coordinator)
        let viewController = SignViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
}

//
//  SettingCoordinator.swift
//  TimePlanner
//
//  Created by Coby on 10/7/24.
//

import UIKit

final class SettingCoordinator: NSObject {
    
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    func dismiss() {
        guard let navigationController = navigationController else { return }
        navigationController.popViewController(animated: true)
    }
    
    func presentLogin() {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        sceneDelegate.moveToLogin()
    }
    
    func presentChangePassword() {
        guard let navigationController = self.navigationController else { return }
        let repository = SignRepositoryImpl()
        let usecase = SignUsecaseImpl(repository: repository)
        let coordinator = ChangePasswordCoordinator(navigationController: navigationController)
        let viewModel = ChangePasswordViewModel(usecase: usecase, coordinator: coordinator)
        let viewController = ChangePasswordViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
}

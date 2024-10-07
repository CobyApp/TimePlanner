//
//  InfoCoordinator.swift
//  TimePlanner
//
//  Created by Coby on 10/5/24.
//

import UIKit

final class InfoCoordinator: NSObject {
    
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    func presentSetting() {
        guard let navigationController = self.navigationController else { return }
        let coordinator = SettingCoordinator(navigationController: navigationController)
        let viewModel = SettingViewModel(coordinator: coordinator)
        let viewController = SettingViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
}

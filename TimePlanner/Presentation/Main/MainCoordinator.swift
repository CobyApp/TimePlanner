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
    
    func presentCategory() {
        guard let navigationController = self.navigationController else {
            print("못옴")
            return
        }
        let coordinator = CategoryCoordinator(navigationController: navigationController)
        let viewModel = CategoryViewModel(coordinator: coordinator)
        let viewController = CategoryViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
}

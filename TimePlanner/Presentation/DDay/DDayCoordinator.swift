//
//  DDayCoordinator.swift
//  TimePlanner
//
//  Created by Coby on 10/5/24.
//

import UIKit

final class DDayCoordinator: NSObject {
    
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    func presentDDayRegister() {
        guard let navigationController = self.navigationController else { return }
        let coordinator = DDayRegisterCoordinator(navigationController: navigationController)
        let viewModel = DDayRegisterViewModel(coordinator: coordinator)
        let viewController = DDayRegisterViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
}

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
    
    func presentDDayRegister(dDay: DDayModel?) {
        guard let navigationController = self.navigationController else { return }
        let repository = DDayRepositoryImpl()
        let usecase = DDayUsecaseImpl(repository: repository)
        let coordinator = DDayRegisterCoordinator(navigationController: navigationController)
        let viewModel = DDayRegisterViewModel(usecase: usecase, coordinator: coordinator, dDay: dDay)
        let viewController = DDayRegisterViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
}

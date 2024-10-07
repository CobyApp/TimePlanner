//
//  NoteCoordinator.swift
//  TimePlanner
//
//  Created by Coby on 10/5/24.
//

import UIKit

final class NoteCoordinator: NSObject {
    
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    func presentNoteRegister() {
        guard let navigationController = self.navigationController else { return }
        let coordinator = NoteRegisterCoordinator(navigationController: navigationController)
        let viewModel = NoteRegisterViewModel(coordinator: coordinator)
        let viewController = NoteRegisterViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
}

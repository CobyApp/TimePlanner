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
    
    func presentNoteRegister(note: NoteModel?) {
        guard let navigationController = self.navigationController else { return }
        let repository = NoteRepositoryImpl()
        let usecase = NoteUsecaseImpl(repository: repository)
        let coordinator = NoteRegisterCoordinator(navigationController: navigationController)
        let viewModel = NoteRegisterViewModel(usecase: usecase, coordinator: coordinator, note: note)
        let viewController = NoteRegisterViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
}

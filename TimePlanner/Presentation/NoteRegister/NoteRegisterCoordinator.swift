//
//  NoteRegisterCoordinator.swift
//  TimePlanner
//
//  Created by Coby on 10/7/24.
//

import UIKit

final class NoteRegisterCoordinator: NSObject {
    
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    func dismiss() {
        guard let navigationController = navigationController else { return }
        navigationController.popViewController(animated: true)
    }
}

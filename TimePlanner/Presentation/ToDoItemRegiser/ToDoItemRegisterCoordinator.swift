//
//  ToDoItemRegisterCoordinator.swift
//  TimePlanner
//
//  Created by Coby on 10/23/24.
//

import UIKit

final class ToDoItemRegisterCoordinator: NSObject {
    
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

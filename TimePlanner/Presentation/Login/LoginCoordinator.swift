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
}

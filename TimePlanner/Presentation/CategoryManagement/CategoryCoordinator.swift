//
//  CategoryManagementCoordinator.swift
//  TimePlanner
//
//  Created by Coby on 10/5/24.
//

import UIKit

final class CategoryManagementCoordinator: NSObject {
    
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
}
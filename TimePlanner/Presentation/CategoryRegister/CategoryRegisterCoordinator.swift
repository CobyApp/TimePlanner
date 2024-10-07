//
//  CategoryRegisterCoordinator.swift
//  TimePlanner
//
//  Created by Coby on 10/7/24.
//

import UIKit

final class CategoryRegisterCoordinator: NSObject {
    
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
}
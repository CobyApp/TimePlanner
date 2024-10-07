//
//  CategoryManagementViewModel.swift
//  TimePlanner
//
//  Created by Coby on 10/5/24.
//

import Foundation

final class CategoryManagementViewModel: NSObject, ObservableObject {
    
    private var coordinator: CategoryManagementCoordinator?
    
    init(
        coordinator: CategoryManagementCoordinator?
    ) {
        self.coordinator = coordinator
    }
}

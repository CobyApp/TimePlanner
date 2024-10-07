//
//  MainViewModel.swift
//  TimePlanner
//
//  Created by Coby on 10/5/24.
//

import Foundation

final class MainViewModel: NSObject, ObservableObject {
    
    private var coordinator: MainCoordinator?
    
    init(
        coordinator: MainCoordinator?
    ) {
        self.coordinator = coordinator
    }
    
    func presentCategoryRegister() {
        self.coordinator?.presentCategoryRegister()
    }
    
    func presentCategoryManagement() {
        self.coordinator?.presentCategoryManagement()
    }
}

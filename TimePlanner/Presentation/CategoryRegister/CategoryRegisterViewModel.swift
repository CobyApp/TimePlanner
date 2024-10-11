//
//  CategoryRegisterViewModel.swift
//  TimePlanner
//
//  Created by Coby on 10/7/24.
//

import Foundation

final class CategoryRegisterViewModel: NSObject, ObservableObject {
    
    private var coordinator: CategoryRegisterCoordinator?
    
    init(
        coordinator: CategoryRegisterCoordinator?
    ) {
        self.coordinator = coordinator
    }
    
    func dismiss() {
        self.coordinator?.dismiss()
    }
}

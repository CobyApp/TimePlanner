//
//  CategoryRegisterViewModel.swift
//  TimePlanner
//
//  Created by Coby on 10/7/24.
//

import Foundation

final class CategoryRegisterViewModel: NSObject, ObservableObject {
    
    @Published var category: CategoryModel = .init()
    
    private let coordinator: CategoryRegisterCoordinator?
    
    init(
        coordinator: CategoryRegisterCoordinator?
    ) {
        self.coordinator = coordinator
    }
    
    func dismiss() {
        self.coordinator?.dismiss()
    }
    
    func registerCategory(
        name: String,
        color: CategoryColor
    ) {
        self.category = CategoryModel(
            name: name,
            color: color
        )
        
        self.dismiss()
    }
}

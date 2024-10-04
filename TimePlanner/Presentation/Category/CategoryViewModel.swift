//
//  CategoryViewModel.swift
//  TimePlanner
//
//  Created by Coby on 10/5/24.
//

import Foundation

final class CategoryViewModel: NSObject, ObservableObject {
    
    private var coordinator: CategoryCoordinator?
    
    init(
        coordinator: CategoryCoordinator?
    ) {
        self.coordinator = coordinator
    }
}

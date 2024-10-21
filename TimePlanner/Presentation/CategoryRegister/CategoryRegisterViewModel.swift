//
//  CategoryRegisterViewModel.swift
//  TimePlanner
//
//  Created by Coby on 10/7/24.
//

import Foundation

final class CategoryRegisterViewModel {
    
    private let usecase: ToDoUsecase
    private let coordinator: CategoryRegisterCoordinator?
    
    var category: CategoryModel?
    
    init(
        usecase: ToDoUsecase,
        coordinator: CategoryRegisterCoordinator?,
        category: CategoryModel? = nil
    ) {
        self.usecase = usecase
        self.coordinator = coordinator
        self.category = category
    }
    
    func dismiss() {
        self.coordinator?.dismiss()
    }
}

extension CategoryRegisterViewModel {
    
    func registerCategory(
        name: String,
        color: CategoryColor
    ) {
        Task {
            do {
                try await self.usecase.createCategory(category: CategoryModel(
                    name: name,
                    color: color
                ))
                
                DispatchQueue.main.async { [weak self] in
                    self?.dismiss()
                }
            } catch(let error) {
                print(error)
            }
        }
    }
}

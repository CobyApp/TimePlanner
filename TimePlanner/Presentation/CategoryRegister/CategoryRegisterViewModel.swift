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
        color: CategoryColor,
        completion: @escaping () -> Void
    ) {
        Task {
            do {
                try await self.usecase.createCategory(category: CategoryModel(
                    name: name,
                    color: color
                ))
                
                DispatchQueue.main.async { [weak self] in
                    completion()
                    self?.dismiss()
                }
            } catch(let error) {
                print(error)
                completion()
            }
        }
    }
    
    func updateCategory(
        name: String,
        color: CategoryColor,
        completion: @escaping () -> Void
    ) {
        guard let category = self.category else {
            print("Category is not set for update.")
            return
        }
        
        Task {
            do {
                let updatedCategory = CategoryModel(
                    id: category.id,
                    name: name,
                    color: color
                )
                
                try await self.usecase.updateCategory(category: updatedCategory)
                
                DispatchQueue.main.async { [weak self] in
                    completion()
                    self?.dismiss()
                }
            } catch(let error) {
                print(error)
                completion()
            }
        }
    }
}

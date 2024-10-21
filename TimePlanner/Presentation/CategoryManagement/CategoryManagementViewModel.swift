//
//  CategoryManagementViewModel.swift
//  TimePlanner
//
//  Created by Coby on 10/5/24.
//

import Foundation

final class CategoryManagementViewModel {
    
    private let usecase: ToDoUsecase
    private let coordinator: CategoryManagementCoordinator?
    
    init(
        usecase: ToDoUsecase,
        coordinator: CategoryManagementCoordinator?
    ) {
        self.usecase = usecase
        self.coordinator = coordinator
    }
    
    func dismiss() {
        self.coordinator?.dismiss()
    }
    
    func presentCategoryRegister() {
        self.coordinator?.presentCategoryRegister()
    }
}

extension CategoryManagementViewModel {
    
    func getCategories(completion: @escaping ([CategoryModel]) -> Void) {
        Task {
            do {
                let categories = try await self.usecase.getCategories()
                completion(categories)
            } catch(let error) {
                print(error)
                completion([])
            }
        }
    }
}

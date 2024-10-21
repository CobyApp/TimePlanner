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
    
    // 추가 모드로 전환
    func presentCategoryRegister() {
        self.coordinator?.presentCategoryRegister(category: nil)
    }

    // 편집 모드로 전환
    func presentCategoryRegister(category: CategoryModel) {
        self.coordinator?.presentCategoryRegister(category: category)
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
    
    func deleteCategory(
        categoryId: String,
        completion: @escaping () -> Void
    ) {
        Task {
            do {
                try await self.usecase.deleteCategory(categoryId: categoryId)
                completion()
            } catch(let error) {
                print(error)
                completion()
            }
        }
    }
}

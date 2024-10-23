//
//  MainViewModel.swift
//  TimePlanner
//
//  Created by Coby on 10/5/24.
//

import Foundation

final class MainViewModel {
    
    private let usecase: ToDoUsecase
    private let coordinator: MainCoordinator?
    
    init(
        usecase: ToDoUsecase,
        coordinator: MainCoordinator?
    ) {
        self.usecase = usecase
        self.coordinator = coordinator
    }
    
    func presentCategoryRegister() {
        self.coordinator?.presentCategoryRegister()
    }
    
    func presentCategoryManagement() {
        self.coordinator?.presentCategoryManagement()
    }
    
    // 추가 모드로 전환
    func presentToDoItemRegister(categoryId: String) {
        self.coordinator?.presentToDoItemRegister(categoryId: categoryId)
    }

    // 편집 모드로 전환
    func presentToDoItemRegister(categoryId: String, toDoItem: ToDoItemModel) {
        self.coordinator?.presentToDoItemRegister(categoryId: categoryId, toDoItem: toDoItem)
    }
}

extension MainViewModel {
    
    func getCategoriesWithFilteredToDoItems(
        date: Date,
        completion: @escaping ([CategoryModel]) -> Void
    ) {
        Task {
            do {
                let categories = try await self.usecase.getCategoriesWithFilteredToDoItems(forDate: date)
                completion(categories)
            } catch(let error) {
                print(error)
                completion([])
            }
        }
    }
}

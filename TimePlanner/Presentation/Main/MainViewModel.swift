//
//  MainViewModel.swift
//  TimePlanner
//
//  Created by Coby on 10/5/24.
//

import Foundation
import UserNotifications

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
    
    func deleteToDoItem(
        categoryId: String,
        toDoItemId: String,
        completion: @escaping () -> Void
    ) {
        Task {
            do {
                try await self.usecase.deleteToDoItem(categoryId: categoryId, itemId: toDoItemId)
                
                // 푸시 알림 삭제
                self.removeNotification(for: toDoItemId)
                
                completion()
            } catch(let error) {
                print(error)
                completion()
            }
        }
    }
    
    func updateToDoItemCheckedStatus(
        categoryId: String,
        itemId: String,
        isChecked: Bool,
        completion: @escaping () -> Void
    ) {
        Task {
            do {
                try await self.usecase.updateToDoItemCheckedStatus(categoryId: categoryId, itemId: itemId, isChecked: isChecked)
                completion()
            } catch(let error) {
                print(error)
                completion()
            }
        }
    }
    
    // MARK: - Remove Notification
    private func removeNotification(for itemId: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [itemId])
    }
}

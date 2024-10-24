//
//  ToDoItemRegisterViewModel.swift
//  TimePlanner
//
//  Created by Coby on 10/23/24.
//

import Foundation

final class ToDoItemRegisterViewModel {
    
    private let usecase: ToDoUsecase
    private let coordinator: ToDoItemRegisterCoordinator?
    
    var categoryId: String
    var toDoItem: ToDoItemModel
    
    init(
        usecase: ToDoUsecase,
        coordinator: ToDoItemRegisterCoordinator?,
        categoryId: String,
        toDoItem: ToDoItemModel
    ) {
        self.usecase = usecase
        self.coordinator = coordinator
        self.categoryId = categoryId
        self.toDoItem = toDoItem
    }
    
    func dismiss() {
        self.coordinator?.dismiss()
    }
}

extension ToDoItemRegisterViewModel {
    
    func registerToDoItem(
        title: String,
        date: Date
    ) {
        Task {
            do {
                try await self.usecase.createToDoItem(
                    categoryId: self.categoryId,
                    item: ToDoItemModel(
                        title: title,
                        date: date
                    )
                )
                
                DispatchQueue.main.async { [weak self] in
                    self?.dismiss()
                }
            } catch(let error) {
                print(error)
            }
        }
    }
    
    func updateToDoItem(
        title: String,
        date: Date
    ) {
        Task {
            do {
                let updatedToDoItem = ToDoItemModel(
                    id: self.toDoItem.id,
                    title: title,
                    isChecked: self.toDoItem.isChecked,
                    date: date
                )
                
                try await self.usecase.updateToDoItem(
                    categoryId: self.categoryId,
                    item: updatedToDoItem
                )
                
                DispatchQueue.main.async { [weak self] in
                    self?.dismiss()
                }
            } catch(let error) {
                print(error)
            }
        }
    }
}

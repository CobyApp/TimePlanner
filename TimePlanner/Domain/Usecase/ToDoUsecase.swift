//
//  ToDoUsecase.swift
//  TimePlanner
//
//  Created by Coby on 10/16/24.
//

import Foundation

protocol ToDoUsecase {
    func createCategory(category: CategoryModel) async throws
    func updateCategory(category: CategoryModel) async throws
    func deleteCategory(categoryId: String) async throws
    func getCategories() async throws -> [CategoryModel]
    func createToDoItem(categoryId: String, item: ToDoItemModel) async throws
    func updateToDoItem(categoryId: String, item: ToDoItemModel) async throws
    func deleteToDoItem(categoryId: String, itemId: String) async throws
    func getToDoItems(categoryId: String) async throws -> [ToDoItemModel]
    func getCategoriesWithFilteredToDoItems(forDate date: Date) async throws -> [CategoryModel]
    func updateToDoItemCheckedStatus(categoryId: String, itemId: String, isChecked: Bool) async throws
    func getCategoriesForDate(_ date: Date) async throws -> [CategoryModel]
}

final class ToDoUsecaseImpl: ToDoUsecase {
    
    // MARK: - property
    
    private let repository: ToDoRepository
    
    // MARK: - init
    
    init(repository: ToDoRepository) {
        self.repository = repository
    }
    
    // MARK: - Public - func
    
    func createCategory(category: CategoryModel) async throws {
        do {
            try await self.repository.createCategory(category: category)
        } catch(let error) {
            throw error
        }
    }
    
    func updateCategory(category: CategoryModel) async throws {
        do {
            try await self.repository.updateCategory(category: category)
        } catch(let error) {
            throw error
        }
    }
    
    func deleteCategory(categoryId: String) async throws {
        do {
            try await self.repository.deleteCategory(categoryId: categoryId)
        } catch(let error) {
            throw error
        }
    }
    
    func getCategories() async throws -> [CategoryModel] {
        do {
            let categories = try await self.repository.getCategories().map { $0.toCategoryModel() }
            return categories
        } catch(let error) {
            throw error
        }
    }
    
    func createToDoItem(categoryId: String, item: ToDoItemModel) async throws {
        do {
            try await self.repository.createToDoItem(categoryId: categoryId, item: item)
        } catch(let error) {
            throw error
        }
    }
    
    func updateToDoItem(categoryId: String, item: ToDoItemModel) async throws {
        do {
            try await self.repository.updateToDoItem(categoryId: categoryId, item: item)
        } catch(let error) {
            throw error
        }
    }
    
    func deleteToDoItem(categoryId: String, itemId: String) async throws {
        do {
            try await self.repository.deleteToDoItem(categoryId: categoryId, itemId: itemId)
        } catch(let error) {
            throw error
        }
    }
    
    func getToDoItems(categoryId: String) async throws -> [ToDoItemModel] {
        do {
            let toDoItems = try await self.repository.getToDoItems(categoryId: categoryId).map { $0.toToDoItemModel() }
            return toDoItems
        } catch(let error) {
            throw error
        }
    }
    
    func getCategoriesWithFilteredToDoItems(forDate date: Date) async throws -> [CategoryModel] {
        do {
            let categories = try await self.repository.getCategoriesWithFilteredToDoItems(forDate: date).map { $0.toCategoryModel() }
            return categories
        } catch(let error) {
            throw error
        }
    }
    
    func updateToDoItemCheckedStatus(categoryId: String, itemId: String, isChecked: Bool) async throws {
        do {
            try await self.repository.updateToDoItemCheckedStatus(categoryId: categoryId, itemId: itemId, isChecked: isChecked)
        } catch(let error) {
            throw error
        }
    }
    
    func getCategoriesForDate(_ date: Date) async throws -> [CategoryModel] {
        do {
            let categories = try await self.repository.getCategoriesForDate(date).map { $0.toCategoryModel() }
            return categories
        } catch(let error) {
            throw error
        }
    }
}

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
}

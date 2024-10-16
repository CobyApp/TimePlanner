//
//  ToDoUsecase.swift
//  TimePlanner
//
//  Created by Coby on 10/16/24.
//

import Foundation

protocol ToDoUsecase {
    func createCategory(category: CategoryModel) async throws
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
    
    func getCategories() async throws -> [CategoryModel] {
        do {
            let categories = try await self.repository.getCategories()
            return categories
        } catch(let error) {
            throw error
        }
    }
}

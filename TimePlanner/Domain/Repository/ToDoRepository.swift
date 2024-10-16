//
//  ToDoRepository.swift
//  TimePlanner
//
//  Created by Coby on 10/16/24.
//

import Foundation

protocol ToDoRepository {
    func createCategory(category: CategoryModel) async throws
    func getCategories() async throws -> [CategoryDTO]
}

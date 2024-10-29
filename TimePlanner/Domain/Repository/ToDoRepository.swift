//
//  ToDoRepository.swift
//  TimePlanner
//
//  Created by Coby on 10/16/24.
//

import Foundation

protocol ToDoRepository {
    func createCategory(category: CategoryModel) async throws
    func updateCategory(category: CategoryModel) async throws
    func deleteCategory(categoryId: String) async throws
    func getCategories() async throws -> [CategoryDTO]
    func createToDoItem(categoryId: String, item: ToDoItemModel) async throws
    func updateToDoItem(categoryId: String, item: ToDoItemModel) async throws
    func deleteToDoItem(categoryId: String, itemId: String) async throws
    func getToDoItems(categoryId: String) async throws -> [ToDoItemDTO]
    func getCategoriesWithFilteredToDoItems(forDate date: Date) async throws -> [CategoryDTO]
    func updateToDoItemCheckedStatus(categoryId: String, itemId: String, isChecked: Bool) async throws
    func getCategoriesForDate(_ date: Date) async throws -> [CategoryDTO]
}

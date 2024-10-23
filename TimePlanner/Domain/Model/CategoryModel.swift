//
//  CategoryModel.swift
//  TimePlanner
//
//  Created by Coby on 10/14/24.
//

import Foundation

struct CategoryModel: Identifiable, Hashable, Equatable {
    
    let id: String
    let name: String
    let color: CategoryColor
    let items: [ToDoItemModel]
    
    init(
        id: String = UUID().uuidString,
        name: String = "",
        color: CategoryColor = .red,
        items: [ToDoItemModel] = []
    ) {
        self.id = id
        self.name = name
        self.color = color
        self.items = items
    }
}

//
//  CategoryMapper.swift
//  TimePlanner
//
//  Created by Coby on 10/16/24.
//

import Foundation

extension CategoryDTO {
    
    func toCategoryModel() -> CategoryModel {
        CategoryModel(
            id: self.id ?? UUID().uuidString,
            name: self.name,
            color: CategoryColor(self.color) ?? .red,
            items: self.items.map { $0.toToDoItemModel() }
        )
    }
}

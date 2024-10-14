//
//  CategoryModel.swift
//  TimePlanner
//
//  Created by Coby on 10/14/24.
//

import Foundation

struct CategoryModel: Identifiable, Hashable, Equatable {
    
    var id: UUID
    var name: String
    var color: CategoryColor
    
    init(
        id: UUID = UUID(),
        name: String = "",
        color: CategoryColor = .red
    ) {
        self.id = id
        self.name = name
        self.color = color
    }
}


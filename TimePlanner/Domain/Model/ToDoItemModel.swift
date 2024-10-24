//
//  ToDoItemModel.swift
//  TimePlanner
//
//  Created by Coby on 10/17/24.
//

import Foundation

struct ToDoItemModel: Identifiable, Hashable, Equatable {
    
    let id: String
    let title: String
    let isChecked: Bool
    let date: Date
    
    init(
        id: String = UUID().uuidString,
        title: String,
        isChecked: Bool = false,
        date: Date = Date()
    ) {
        self.id = id
        self.title = title
        self.isChecked = isChecked
        self.date = date
    }
}

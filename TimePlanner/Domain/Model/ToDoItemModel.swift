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
    var isChecked: Bool
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

extension [ToDoItemModel] {
    
    var totalToDo: Int {
        self.count
    }
    
    var checkedToDo: Int {
        self.filter { $0.isChecked }.count
    }
    
    var completionRate: Double {
        guard self.totalToDo > 0 else { return 0.0 }
        return Double(self.checkedToDo) / Double(self.totalToDo)
    }
}

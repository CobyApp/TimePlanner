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

extension [CategoryModel] {
    
    // 총 할 일 갯수
    var totalToDo: Int {
        self.reduce(0) { $0 + $1.items.totalToDo }
    }
    
    // 완료된 할 일 갯수
    var checkedToDo: Int {
        self.reduce(0) { $0 + $1.items.checkedToDo }
    }
    
    // 완료된 비율 (0.0 ~ 1.0 사이의 값)
    var completionRate: Double {
        guard self.totalToDo > 0 else { return 0.0 }
        return Double(self.checkedToDo) / Double(self.totalToDo)
    }
}

extension CategoryModel {
    func toProgressBarModel() -> ProgressBarModel {
        ProgressBarModel(
            completionCount: self.items.checkedToDo,
            totalCount: self.items.totalToDo,
            completedColor: self.color.color
        )
    }
}

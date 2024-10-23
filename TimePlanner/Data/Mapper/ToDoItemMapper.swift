//
//  ToDoItemMapper.swift
//  TimePlanner
//
//  Created by Coby on 10/23/24.
//

import Foundation

extension ToDoItemDTO {
    
    func toToDoItemModel() -> ToDoItemModel {
        ToDoItemModel(
            id: self.id ?? UUID().uuidString,
            title: self.title,
            isChecked: self.isChecked,
            date: self.date
        )
    }
}

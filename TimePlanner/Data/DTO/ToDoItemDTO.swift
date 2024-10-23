//
//  ToDoItemDTO.swift
//  TimePlanner
//
//  Created by Coby on 10/23/24.
//

import FirebaseFirestore

struct ToDoItemDTO: Codable, Identifiable, Equatable, Hashable {
    
    @DocumentID var id: String?
    
    let title: String
    let isChecked: Bool
    let date: Date
}

//
//  NoteModel.swift
//  TimePlanner
//
//  Created by Coby on 10/14/24.
//

import Foundation

struct NoteModel: Identifiable, Hashable, Equatable {
    
    var id: UUID
    var content: String
    var createdAt: Date
    
    init(
        id: UUID = UUID(),
        content: String = "",
        createdAt: Date = Date()
    ) {
        self.id = id
        self.content = content
        self.createdAt = createdAt
    }
}

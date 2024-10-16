//
//  NoteModel.swift
//  TimePlanner
//
//  Created by Coby on 10/14/24.
//

import Foundation

struct NoteModel: Identifiable, Hashable, Equatable {
    
    let id: String
    let content: String
    let createdAt: Date
    
    init(
        id: String = UUID().uuidString,
        content: String = "",
        createdAt: Date = Date()
    ) {
        self.id = id
        self.content = content
        self.createdAt = createdAt
    }
}

//
//  NoteMapper.swift
//  TimePlanner
//
//  Created by Coby on 10/21/24.
//

import Foundation

extension NoteDTO {
    
    func toNoteModel() -> NoteModel {
        return NoteModel(
            id: self.id ?? UUID().uuidString,
            content: self.content,
            createdAt: self.createdAt
        )
    }
}

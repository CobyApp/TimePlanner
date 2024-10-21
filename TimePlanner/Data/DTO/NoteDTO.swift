//
//  NoteDTO.swift
//  TimePlanner
//
//  Created by Coby on 10/21/24.
//

import FirebaseFirestore

struct NoteDTO: Identifiable, Hashable, Equatable {
    
    @DocumentID var id: String?
    
    let content: String
    let createdAt: Date
}

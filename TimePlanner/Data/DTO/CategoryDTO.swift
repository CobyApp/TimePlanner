//
//  CategoryDTO.swift
//  TimePlanner
//
//  Created by Coby on 10/16/24.
//

import FirebaseFirestore

struct CategoryDTO: Codable, Identifiable, Equatable, Hashable {
    
    @DocumentID var id: String?
    
    let name: String
    let color: String
}

//
//  UserDTO.swift
//  TimePlanner
//
//  Created by Coby on 10/16/24.
//

import FirebaseFirestore

struct UserDTO: Codable, Identifiable, Equatable, Hashable {
    
    @DocumentID var id: String?
    
    let email: String
}

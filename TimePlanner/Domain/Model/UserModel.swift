//
//  UserModel.swift
//  TimePlanner
//
//  Created by Coby on 10/15/24.
//

import Foundation

struct UserModel: Identifiable, Hashable, Equatable {
    
    var id: UUID
    var email: String
    
    init(
        id: UUID = UUID(),
        email: String = ""
    ) {
        self.id = id
        self.email = email
    }
}

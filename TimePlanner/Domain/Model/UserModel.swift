//
//  UserModel.swift
//  TimePlanner
//
//  Created by Coby on 10/15/24.
//

import Foundation

struct UserModel: Identifiable, Hashable, Equatable {
    
    let id: String
    let email: String
    
    init(
        id: String = UUID().uuidString,
        email: String = ""
    ) {
        self.id = id
        self.email = email
    }
}

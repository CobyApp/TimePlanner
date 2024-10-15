//
//  UserMapper.swift
//  TimePlanner
//
//  Created by Coby on 10/15/24.
//

import Foundation

import FirebaseAuth

extension FirebaseAuth.User {
    
    func toUserModel() -> UserModel {
        return UserModel(
            id: UUID(uuidString: self.uid) ?? UUID(),
            email: self.email ?? ""
        )
    }
}

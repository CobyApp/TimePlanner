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
            id: self.uid,
            email: self.email ?? ""
        )
    }
}

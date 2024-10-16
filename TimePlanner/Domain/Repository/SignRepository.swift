//
//  SignRepository.swift
//  TimePlanner
//
//  Created by Coby on 10/15/24.
//

import Foundation

import FirebaseAuth

protocol SignRepository {
    func signInWithEmail(email: String, password: String) async throws -> FirebaseAuth.User
    func signUpWithEmail(email: String, password: String) async throws -> FirebaseAuth.User
    func signOut() throws
    func saveUser(user: UserModel) async throws
}

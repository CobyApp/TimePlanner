//
//  SignUsecase.swift
//  TimePlanner
//
//  Created by Coby on 10/15/24.
//

import Foundation

protocol SignUsecase {
    func signInWithEmail(email: String, password: String) async throws -> UserModel
    func signUpWithEmail(email: String, password: String) async throws -> UserModel
    func signOut() throws
    func saveUser(user: UserModel) async throws
    func deleteUser() async throws
    func changePassword(newPassword: String) async throws
}

final class SignUsecaseImpl: SignUsecase {
       
    // MARK: - property
    
    private let repository: SignRepository
    
    // MARK: - init
    
    init(repository: SignRepository) {
        self.repository = repository
    }
    
    // MARK: - Public - func
    
    func signInWithEmail(email: String, password: String) async throws -> UserModel {
        do {
            let userDTO = try await self.repository.signInWithEmail(email: email, password: password)
            return userDTO.toUserModel()
        } catch(let error) {
            throw error
        }
    }
    
    func signUpWithEmail(email: String, password: String) async throws -> UserModel {
        do {
            let userDTO = try await self.repository.signUpWithEmail(email: email, password: password)
            return userDTO.toUserModel()
        } catch(let error) {
            throw error
        }
    }
    
    func signOut() throws {
        do {
            try self.repository.signOut()
        } catch(let error) {
            throw error
        }
    }
    
    func saveUser(user: UserModel) async throws {
        do {
            try await self.repository.saveUser(user: user)
        } catch(let error) {
            throw error
        }
    }
    
    func deleteUser() async throws {
        do {
            try await self.repository.deleteUser()
        } catch(let error) {
            throw error
        }
    }
    
    func changePassword(newPassword: String) async throws {
        do {
            try await self.repository.changePassword(newPassword: newPassword)
        } catch(let error) {
            throw error
        }
    }
}

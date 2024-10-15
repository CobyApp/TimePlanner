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
}

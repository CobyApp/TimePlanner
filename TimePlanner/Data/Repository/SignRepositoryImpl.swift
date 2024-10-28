//
//  SignRepositoryImpl.swift
//  TimePlanner
//
//  Created by Coby on 10/15/24.
//

import Foundation

import FirebaseAuth
import FirebaseFirestore

final class SignRepositoryImpl: SignRepository {
    
    private let db = Firestore.firestore()
    
    func signInWithEmail(email: String, password: String) async throws -> FirebaseAuth.User {
        try await withCheckedThrowingContinuation { continuation in
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                
                guard let user = authResult?.user else {
                    continuation.resume(throwing: NSError(domain: "FirebaseAuth", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to retrieve user after login"]))
                    return
                }
                continuation.resume(returning: user)
            }
        }
    }
    
    func signUpWithEmail(email: String, password: String) async throws -> FirebaseAuth.User {
        try await withCheckedThrowingContinuation { continuation in
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                
                guard let user = authResult?.user else {
                    continuation.resume(throwing: NSError(domain: "FirebaseAuth", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to retrieve user after signup"]))
                    return
                }
                continuation.resume(returning: user)
            }
        }
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    func saveUser(user: UserModel) async throws {
        let userData: [String: Any] = [
            "id": user.id,
            "email": user.email
        ]
        
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            self.db.collection("users").document(user.id).setData(userData) { error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume()
                }
            }
        }
    }
    
    func deleteUser(password: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw NSError(domain: "FirebaseAuth", code: -1, userInfo: [NSLocalizedDescriptionKey: "No current user found"])
        }
        
        try await self.reauthenticate(password: password)

        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            self.db.collection("users").document(user.uid).delete { error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    user.delete { error in
                        if let error = error {
                            continuation.resume(throwing: error)
                        } else {
                            continuation.resume()
                        }
                    }
                }
            }
        }
    }
    
    func changePassword(password: String, newPassword: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw NSError(domain: "FirebaseAuth", code: -1, userInfo: [NSLocalizedDescriptionKey: "No current user found"])
        }
        
        try await self.reauthenticate(password: password)

        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            user.updatePassword(to: newPassword) { error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume()
                }
            }
        }
    }
    
    func reauthenticate(password: String) async throws {
        guard let user = Auth.auth().currentUser, let email = user.email else {
            throw NSError(domain: "FirebaseAuth", code: -1, userInfo: [NSLocalizedDescriptionKey: "No current user found or email is missing"])
        }
        
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            user.reauthenticate(with: credential) { _, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume()
                }
            }
        }
    }
}

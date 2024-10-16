//
//  SignViewModel.swift
//  TimePlanner
//
//  Created by Coby on 10/14/24.
//

import Foundation

final class SignViewModel {
    
    private let usecase: SignUsecase
    private let coordinator: SignCoordinator?
    
    init(
        usecase: SignUsecase,
        coordinator: SignCoordinator?
    ) {
        self.usecase = usecase
        self.coordinator = coordinator
    }
    
    func dismiss() {
        self.coordinator?.dismiss()
    }
    
    func presentTabbar() {
        self.coordinator?.presentTabbar()
    }
}

extension SignViewModel {
    
    func signUser(
        email: String,
        password: String
    ) {
        Task {
            do {
                let _ = try await self.usecase.signUpWithEmail(email: email, password: password)
                
                self.loginUser(email: email, password: password)
            } catch(let error) {
                print(error)
            }
        }
    }
    
    func loginUser(
        email: String,
        password: String
    ) {
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let user = try await self.usecase.signInWithEmail(email: email, password: password)
                
                self.saveUser(user: user)
            } catch(let error) {
                print(error)
            }
        }
    }
    
    func saveUser(user: UserModel) {
        Task {
            do {
                try await self.usecase.saveUser(user: user)
                
                DispatchQueue.main.async { [weak self] in
                    self?.presentTabbar()
                }
            } catch(let error) {
                print(error)
            }
        }
    }
}

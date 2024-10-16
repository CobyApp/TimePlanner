//
//  LoginViewModel.swift
//  TimePlanner
//
//  Created by Coby on 10/14/24.
//

import Foundation

final class LoginViewModel {
    
    private let usecase: SignUsecase
    private let coordinator: LoginCoordinator?
    
    init(
        usecase: SignUsecase,
        coordinator: LoginCoordinator?
    ) {
        self.usecase = usecase
        self.coordinator = coordinator
    }
    
    func presentSign() {
        self.coordinator?.presentSign()
    }
    
    func presentTabbar() {
        self.coordinator?.presentTabbar()
    }
}
    
extension LoginViewModel {
    
    func loginUser(
        email: String,
        password: String
    ) {
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let user = try await self.usecase.signInWithEmail(email: email, password: password)
                
                DispatchQueue.main.async { [weak self] in
                    self?.presentTabbar()
                }
            } catch(let error) {
                print(error)
            }
        }
    }
}

//
//  LoginViewModel.swift
//  TimePlanner
//
//  Created by Coby on 10/14/24.
//

import Foundation

final class LoginViewModel {
    
    private let usecase: SignUsecase
    private weak var coordinator: LoginCoordinator?
    
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
    
    func loginUser(
        email: String,
        password: String
    ) {
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let user = try await self.usecase.signInWithEmail(email: email, password: password)
                print(user)
            } catch(let error) {
                print(error)
            }
        }
    }
}

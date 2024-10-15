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
    
    func signUser(
        email: String,
        password: String
    ) {
        Task {
            do {
                let user = try await self.usecase.signUpWithEmail(email: email, password: password)
                
                DispatchQueue.main.async { [weak self] in
                    self?.dismiss()
                }
            } catch(let error) {
                print(error)
            }
        }
    }
}

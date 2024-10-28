//
//  ChangePasswordViewModel.swift
//  TimePlanner
//
//  Created by Coby on 10/25/24.
//

import Foundation

final class ChangePasswordViewModel {
    
    private let usecase: SignUsecase
    private let coordinator: ChangePasswordCoordinator?
    
    init(
        usecase: SignUsecase,
        coordinator: ChangePasswordCoordinator?
    ) {
        self.usecase = usecase
        self.coordinator = coordinator
    }
    
    func dismiss() {
        self.coordinator?.dismiss()
    }
}

extension ChangePasswordViewModel {
    
    func changePassword(
        password: String,
        newPassword: String
    ) {
        Task {
            do {
                try await self.usecase.changePassword(password: password, newPassword: newPassword)
                
                DispatchQueue.main.async { [weak self] in
                    self?.dismiss()
                }
            } catch(let error) {
                print(error)
            }
        }
    }
}

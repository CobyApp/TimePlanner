//
//  SettingViewModel.swift
//  TimePlanner
//
//  Created by Coby on 10/7/24.
//

import Foundation

final class SettingViewModel {
    
    private let usecase: SignUsecase
    private let coordinator: SettingCoordinator?
    
    init(
        usecase: SignUsecase,
        coordinator: SettingCoordinator?
    ) {
        self.usecase = usecase
        self.coordinator = coordinator
    }
    
    func dismiss() {
        self.coordinator?.dismiss()
    }
    
    func presentLogin() {
        self.coordinator?.presentLogin()
    }
    
    func signOut() {
        do {
            try self.usecase.signOut()
            
            DispatchQueue.main.async { [weak self] in
                self?.presentLogin()
            }
        } catch(let error) {
            print(error)
        }
    }
}

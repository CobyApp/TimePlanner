//
//  SettingViewModel.swift
//  TimePlanner
//
//  Created by Coby on 10/7/24.
//

import UIKit

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
    
    func presentChangePassword() {
        self.coordinator?.presentChangePassword()
    }
}

extension SettingViewModel {
    
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
    
    func deleteUser(
        password: String,
        completion: @escaping () -> Void,
        errorAlert: @escaping () -> Void
    ) {
        Task {
            do {
                try await self.usecase.deleteUser(password: password)
                
                DispatchQueue.main.async { [weak self] in
                    completion()
                    self?.presentLogin()
                }
            } catch {
                completion()
                errorAlert()
            }
        }
    }
    
    func presentNotificationSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

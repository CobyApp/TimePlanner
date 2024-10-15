//
//  LoginViewModel.swift
//  TimePlanner
//
//  Created by Coby on 10/14/24.
//

import Foundation

final class LoginViewModel: NSObject, ObservableObject {
    
    private let usecase: SignUsecase
    private var coordinator: LoginCoordinator?
    
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
    }
}

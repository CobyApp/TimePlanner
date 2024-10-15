//
//  SignViewModel.swift
//  TimePlanner
//
//  Created by Coby on 10/14/24.
//

import Foundation

final class SignViewModel: NSObject, ObservableObject {
    
    private let usecase: SignUsecase
    private var coordinator: SignCoordinator?
    
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
    }
}

//
//  LoginViewModel.swift
//  TimePlanner
//
//  Created by Coby on 10/14/24.
//

import Foundation

final class LoginViewModel: NSObject, ObservableObject {
    
//    @Published var note: NoteModel = .init()
    
    private var coordinator: LoginCoordinator?
    
    init(
        coordinator: LoginCoordinator?
    ) {
        self.coordinator = coordinator
    }
    
    func loginUser(
        content: String
    ) {
    }
}

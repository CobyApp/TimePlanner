//
//  SignViewModel.swift
//  TimePlanner
//
//  Created by Coby on 10/14/24.
//

import Foundation

final class SignViewModel: NSObject, ObservableObject {
    
//    @Published var note: NoteModel = .init()
    
    private var coordinator: SignCoordinator?
    
    init(
        coordinator: SignCoordinator?
    ) {
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

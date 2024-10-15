//
//  NoteRegisterViewModel.swift
//  TimePlanner
//
//  Created by Coby on 10/7/24.
//

import Foundation

final class NoteRegisterViewModel {
    
    @Published var note: NoteModel = .init()
    
    private let coordinator: NoteRegisterCoordinator?
    
    init(
        coordinator: NoteRegisterCoordinator?
    ) {
        self.coordinator = coordinator
    }
    
    func dismiss() {
        self.coordinator?.dismiss()
    }
    
    func registerNote(
        content: String
    ) {
        self.note = NoteModel(
            content: content
        )
        
        self.dismiss()
    }
}

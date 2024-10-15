//
//  NoteViewModel.swift
//  TimePlanner
//
//  Created by Coby on 10/5/24.
//

import Foundation

final class NoteViewModel: NSObject, ObservableObject {
    
    private let coordinator: NoteCoordinator?
    
    init(
        coordinator: NoteCoordinator?
    ) {
        self.coordinator = coordinator
    }
    
    func presentNoteRegister() {
        self.coordinator?.presentNoteRegister()
    }
}

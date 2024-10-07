//
//  NoteRegisterViewModel.swift
//  TimePlanner
//
//  Created by Coby on 10/7/24.
//

import Foundation

final class NoteRegisterViewModel: NSObject, ObservableObject {
    
    private var coordinator: NoteRegisterCoordinator?
    
    init(
        coordinator: NoteRegisterCoordinator?
    ) {
        self.coordinator = coordinator
    }
}

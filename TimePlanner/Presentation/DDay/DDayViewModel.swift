//
//  DDayViewModel.swift
//  TimePlanner
//
//  Created by Coby on 10/5/24.
//

import Foundation

final class DDayViewModel: NSObject, ObservableObject {
    
    private let coordinator: DDayCoordinator?
    
    init(
        coordinator: DDayCoordinator?
    ) {
        self.coordinator = coordinator
    }
    
    func presentDDayRegister() {
        self.coordinator?.presentDDayRegister()
    }
}

//
//  DDayRegisterViewModel.swift
//  TimePlanner
//
//  Created by Coby on 10/7/24.
//

import Foundation

final class DDayRegisterViewModel: NSObject, ObservableObject {
    
    private var coordinator: DDayRegisterCoordinator?
    
    init(
        coordinator: DDayRegisterCoordinator?
    ) {
        self.coordinator = coordinator
    }
    
    func dismiss() {
        self.coordinator?.dismiss()
    }
}

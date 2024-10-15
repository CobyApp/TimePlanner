//
//  SettingViewModel.swift
//  TimePlanner
//
//  Created by Coby on 10/7/24.
//

import Foundation

final class SettingViewModel {
    
    private let coordinator: SettingCoordinator?
    
    init(
        coordinator: SettingCoordinator?
    ) {
        self.coordinator = coordinator
    }
    
    func dismiss() {
        self.coordinator?.dismiss()
    }
}

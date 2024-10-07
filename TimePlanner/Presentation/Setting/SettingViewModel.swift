//
//  SettingViewModel.swift
//  TimePlanner
//
//  Created by Coby on 10/7/24.
//

import Foundation

final class SettingViewModel: NSObject, ObservableObject {
    
    private var coordinator: SettingCoordinator?
    
    init(
        coordinator: SettingCoordinator?
    ) {
        self.coordinator = coordinator
    }
}

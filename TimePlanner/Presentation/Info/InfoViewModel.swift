//
//  InfoViewModel.swift
//  TimePlanner
//
//  Created by Coby on 10/5/24.
//

import Foundation

final class InfoViewModel: NSObject, ObservableObject {
    
    private let coordinator: InfoCoordinator?
    
    init(
        coordinator: InfoCoordinator?
    ) {
        self.coordinator = coordinator
    }
    
    func presentSetting() {
        self.coordinator?.presentSetting()
    }
}

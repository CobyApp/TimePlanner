//
//  InfoViewModel.swift
//  TimePlanner
//
//  Created by Coby on 10/5/24.
//

import Foundation

final class InfoViewModel: NSObject, ObservableObject {
    
    private var coordinator: InfoCoordinator?
    
    init(
        coordinator: InfoCoordinator?
    ) {
        self.coordinator = coordinator
    }
}

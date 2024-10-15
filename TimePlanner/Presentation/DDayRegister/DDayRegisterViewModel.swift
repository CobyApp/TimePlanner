//
//  DDayRegisterViewModel.swift
//  TimePlanner
//
//  Created by Coby on 10/7/24.
//

import Foundation

final class DDayRegisterViewModel: NSObject, ObservableObject {
    
    @Published var dDay: DDayModel = .init()
    
    private let coordinator: DDayRegisterCoordinator?
    
    init(
        coordinator: DDayRegisterCoordinator?
    ) {
        self.coordinator = coordinator
    }
    
    func dismiss() {
        self.coordinator?.dismiss()
    }
    
    func registerDDay(
        name: String,
        dDate: Date
    ) {
        self.dDay = DDayModel(
            name: name,
            dDate: dDate
        )
        
        self.dismiss()
    }
}

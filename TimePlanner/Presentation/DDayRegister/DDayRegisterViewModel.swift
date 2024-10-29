//
//  DDayRegisterViewModel.swift
//  TimePlanner
//
//  Created by Coby on 10/7/24.
//

import Foundation

final class DDayRegisterViewModel {
    
    private let usecase: DDayUsecase
    private let coordinator: DDayRegisterCoordinator?
    
    var dDay: DDayModel?
    
    init(
        usecase: DDayUsecase,
        coordinator: DDayRegisterCoordinator?,
        dDay: DDayModel? = nil
    ) {
        self.usecase = usecase
        self.coordinator = coordinator
        self.dDay = dDay
    }
    
    func dismiss() {
        self.coordinator?.dismiss()
    }
}

extension DDayRegisterViewModel {
    
    func registerDDay(
        name: String,
        dDate: Date,
        completion: @escaping () -> Void
    ) {
        Task {
            do {
                try await self.usecase.createDDay(dDay: DDayModel(
                    name: name,
                    dDate: dDate
                ))
                
                DispatchQueue.main.async { [weak self] in
                    completion()
                    self?.dismiss()
                }
            } catch(let error) {
                print(error)
                completion()
            }
        }
    }
    
    func updateDDay(
        name: String,
        dDate: Date,
        completion: @escaping () -> Void
    ) {
        guard let dDay = self.dDay else {
            print("DDay is not set for update.")
            return
        }
        
        Task {
            do {
                let updatedDDay = DDayModel(
                    id: dDay.id,
                    name: name,
                    dDate: dDate
                )
                
                try await self.usecase.updateDDay(dDay: updatedDDay)
                
                DispatchQueue.main.async { [weak self] in
                    completion()
                    self?.dismiss()
                }
            } catch(let error) {
                print(error)
                completion()
            }
        }
    }
}

//
//  DDayViewModel.swift
//  TimePlanner
//
//  Created by Coby on 10/5/24.
//

import Foundation
import UserNotifications

final class DDayViewModel {
    
    private let usecase: DDayUsecase
    private let coordinator: DDayCoordinator?
    
    init(
        usecase: DDayUsecase,
        coordinator: DDayCoordinator?
    ) {
        self.usecase = usecase
        self.coordinator = coordinator
    }
    
    func presentDDayRegister() {
        self.coordinator?.presentDDayRegister(dDay: nil)
    }
    
    func presentDDayRegister(dDay: DDayModel) {
        self.coordinator?.presentDDayRegister(dDay: dDay)
    }
}

extension DDayViewModel {
    
    func getDDays(completion: @escaping ([DDayModel]) -> Void) {
        Task {
            do {
                let dDays = try await self.usecase.getDDays()
                completion(dDays)
            } catch(let error) {
                print(error)
                completion([])
            }
        }
    }
    
    func deleteDDay(
        dDayId: String,
        completion: @escaping () -> Void
    ) {
        Task {
            do {
                try await self.usecase.deleteDDay(dDayId: dDayId)
                
                // 푸시 알림 삭제
                self.removeNotification(for: dDayId)

                completion()
            } catch(let error) {
                print(error)
                completion()
            }
        }
    }
    
    // MARK: - Remove Notification
    private func removeNotification(for dDayId: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [dDayId])
    }
}

//
//  DDayRegisterViewModel.swift
//  TimePlanner
//
//  Created by Coby on 10/7/24.
//

import Foundation
import UserNotifications

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
                let newDDay = DDayModel(
                    name: name,
                    dDate: dDate
                )
                
                // DDay 등록
                try await self.usecase.createDDay(dDay: newDDay)

                // 알림 예약
                self.scheduleNotification(for: newDDay)

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
                
                // 기존 DDay 업데이트
                try await self.usecase.updateDDay(dDay: updatedDDay)
                
                // 기존 알림 삭제 및 새 알림 등록
                self.updateNotification(for: updatedDDay)

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
    
    // MARK: - Schedule Notification
    private func scheduleNotification(for dDay: DDayModel) {
        let content = UNMutableNotificationContent()
        content.title = "D-Day 알림"
        content.body = "D-Day \(dDay.name) 입니다!"
        content.sound = .default
        
        // D-Day의 date에 대한 트리거 생성
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: dDay.dDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        // 요청 생성
        let request = UNNotificationRequest(identifier: dDay.id, content: content, trigger: trigger)
        
        // 알림 등록
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("알림 등록 오류: \(error.localizedDescription)")
            }
        }
    }

    // MARK: - Update Notification
    private func updateNotification(for dDay: DDayModel) {
        // 기존 알림 삭제
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [dDay.id])

        // 새 알림 예약
        self.scheduleNotification(for: dDay)
    }
}

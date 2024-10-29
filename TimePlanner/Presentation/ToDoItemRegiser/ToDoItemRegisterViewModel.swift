//
//  ToDoItemRegisterViewModel.swift
//  TimePlanner
//
//  Created by Coby on 10/23/24.
//

import Foundation
import UserNotifications

final class ToDoItemRegisterViewModel {
    
    private let usecase: ToDoUsecase
    private let coordinator: ToDoItemRegisterCoordinator?
    
    var categoryId: String
    var toDoItem: ToDoItemModel
    
    init(
        usecase: ToDoUsecase,
        coordinator: ToDoItemRegisterCoordinator?,
        categoryId: String,
        toDoItem: ToDoItemModel
    ) {
        self.usecase = usecase
        self.coordinator = coordinator
        self.categoryId = categoryId
        self.toDoItem = toDoItem
    }
    
    func dismiss() {
        self.coordinator?.dismiss()
    }
}

extension ToDoItemRegisterViewModel {
    
    func registerToDoItem(
        title: String,
        date: Date,
        completion: @escaping () -> Void
    ) {
        Task {
            do {
                let newToDoItem = ToDoItemModel(
                    title: title,
                    date: date
                )
                
                try await self.usecase.createToDoItem(
                    categoryId: self.categoryId,
                    item: newToDoItem
                )
                
                // 알림 예약
                self.scheduleNotification(for: newToDoItem)

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
    
    func updateToDoItem(
        title: String,
        date: Date,
        completion: @escaping () -> Void
    ) {
        Task {
            do {
                let updatedToDoItem = ToDoItemModel(
                    id: self.toDoItem.id,
                    title: title,
                    isChecked: self.toDoItem.isChecked,
                    date: date
                )
                
                try await self.usecase.updateToDoItem(
                    categoryId: self.categoryId,
                    item: updatedToDoItem
                )
                
                // 기존 알림 삭제 및 새 알림 등록
                self.updateNotification(for: updatedToDoItem)

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
    private func scheduleNotification(for toDoItem: ToDoItemModel) {
        let content = UNMutableNotificationContent()
        content.title = "할일 알림"
        content.body = "\(toDoItem.title)입니다!"
        content.sound = .default
        
        // ToDo 아이템의 date에 대한 트리거 생성
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: toDoItem.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        // 요청 생성
        let request = UNNotificationRequest(identifier: toDoItem.id, content: content, trigger: trigger)
        
        // 알림 등록
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("알림 등록 오류: \(error.localizedDescription)")
            }
        }
    }

    // MARK: - Update Notification
    private func updateNotification(for toDoItem: ToDoItemModel) {
        // 기존 알림 삭제
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [toDoItem.id])

        // 새 알림 예약
        self.scheduleNotification(for: toDoItem)
    }
}

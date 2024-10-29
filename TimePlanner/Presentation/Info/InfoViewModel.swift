//
//  InfoViewModel.swift
//  TimePlanner
//
//  Created by Coby on 10/5/24.
//

import Foundation

final class InfoViewModel {
    
    private let signUsecase: SignUsecase
    private let toDoUsecase: ToDoUsecase
    private let noteUsecase: NoteUsecase
    private let dDayUsecase: DDayUsecase
    private let coordinator: InfoCoordinator?
    
    init(
        signUsecase: SignUsecase,
        toDoUsecase: ToDoUsecase,
        noteUsecase: NoteUsecase,
        dDayUsecase: DDayUsecase,
        coordinator: InfoCoordinator?
    ) {
        self.signUsecase = signUsecase
        self.toDoUsecase = toDoUsecase
        self.noteUsecase = noteUsecase
        self.dDayUsecase = dDayUsecase
        self.coordinator = coordinator
    }
    
    func presentSetting() {
        self.coordinator?.presentSetting()
    }
}

extension InfoViewModel {
    
    func getCategories(
        date: Date,
        completion: @escaping ([CategoryModel]) -> Void
    ) {
        Task {
            do {
                let categories = try await self.toDoUsecase.getCategoriesForDate(date)
                completion(categories)
            } catch(let error) {
                print(error)
                completion([])
            }
        }
    }
    
    func getNotes(
        date: Date,
        completion: @escaping ([NoteModel]) -> Void
    ) {
        Task {
            do {
                let notes = try await self.noteUsecase.getNotesForDate(date)
                completion(notes)
            } catch(let error) {
                print(error)
                completion([])
            }
        }
    }
    
    func getDDay(
        date: Date,
        completion: @escaping ([DDayModel]) -> Void
    ) {
        Task {
            do {
                let dDays = try await self.dDayUsecase.getDDaysForDate(date)
                completion(dDays)
            } catch(let error) {
                print(error)
                completion([])
            }
        }
    }
}

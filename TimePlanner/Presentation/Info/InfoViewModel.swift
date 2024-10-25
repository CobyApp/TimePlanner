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

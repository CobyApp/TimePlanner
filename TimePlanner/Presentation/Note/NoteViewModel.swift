//
//  NoteViewModel.swift
//  TimePlanner
//
//  Created by Coby on 10/5/24.
//

import Foundation

final class NoteViewModel {
    
    private let usecase: NoteUsecase
    private let coordinator: NoteCoordinator?
    
    init(
        usecase: NoteUsecase,
        coordinator: NoteCoordinator?
    ) {
        self.usecase = usecase
        self.coordinator = coordinator
    }
    
    func presentNoteRegister() {
        self.coordinator?.presentNoteRegister(note: nil)
    }
    
    func presentNoteRegister(note: NoteModel) {
        self.coordinator?.presentNoteRegister(note: note)
    }
}

extension NoteViewModel {
    
    func getNotes(completion: @escaping ([NoteModel]) -> Void) {
        Task {
            do {
                let notes = try await self.usecase.getNotes()
                completion(notes)
            } catch(let error) {
                print(error)
                completion([])
            }
        }
    }
    
    func deleteNote(
        noteId: String,
        completion: @escaping () -> Void
    ) {
        Task {
            do {
                try await self.usecase.deleteNote(noteId: noteId)
                completion()
            } catch(let error) {
                print(error)
                completion()
            }
        }
    }
}

//
//  NoteRegisterViewModel.swift
//  TimePlanner
//
//  Created by Coby on 10/7/24.
//

import Foundation

final class NoteRegisterViewModel {
    
    private let usecase: NoteUsecase
    private let coordinator: NoteRegisterCoordinator?
    
    var note: NoteModel?
    
    init(
        usecase: NoteUsecase,
        coordinator: NoteRegisterCoordinator?,
        note: NoteModel? = nil
    ) {
        self.usecase = usecase
        self.coordinator = coordinator
        self.note = note
    }
    
    func dismiss() {
        self.coordinator?.dismiss()
    }
}

extension NoteRegisterViewModel {
    
    func registerNote(
        content: String,
        completion: @escaping () -> Void
    ) {
        Task {
            do {
                try await self.usecase.createNote(note: NoteModel(
                    content: content,
                    createdAt: Date()
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
    
    func updateNote(
        content: String,
        completion: @escaping () -> Void
    ) {
        guard let note = self.note else {
            print("Note is not set for update.")
            return
        }
        
        Task {
            do {
                let updatedNote = NoteModel(
                    id: note.id,
                    content: content,
                    createdAt: Date()
                )
                
                try await self.usecase.updateNote(note: updatedNote)
                
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

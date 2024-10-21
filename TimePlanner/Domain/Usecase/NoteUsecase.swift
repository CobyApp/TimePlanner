//
//  NoteUsecase.swift
//  TimePlanner
//
//  Created by Coby on 10/21/24.
//

import Foundation

protocol NoteUsecase {
    func createNote(note: NoteModel) async throws
    func updateNote(note: NoteModel) async throws
    func deleteNote(noteId: String) async throws
    func getNotes() async throws -> [NoteModel]
}

final class NoteUsecaseImpl: NoteUsecase {
       
    // MARK: - property
    
    private let repository: NoteRepository
    
    // MARK: - init
    
    init(repository: NoteRepository) {
        self.repository = repository
    }
    
    // MARK: - Public - func
    
    func createNote(note: NoteModel) async throws {
        do {
            try await self.repository.createNote(note: note)
        } catch(let error) {
            throw error
        }
    }
    
    func updateNote(note: NoteModel) async throws {
        do {
            try await self.repository.updateNote(note: note)
        } catch(let error) {
            throw error
        }
    }
    
    func deleteNote(noteId: String) async throws {
        do {
            try await self.repository.deleteNote(noteId: noteId)
        } catch(let error) {
            throw error
        }
    }
    
    func getNotes() async throws -> [NoteModel] {
        do {
            let notes = try await self.repository.getNotes().map { $0.toNoteModel() }
            return notes
        } catch(let error) {
            throw error
        }
    }
}

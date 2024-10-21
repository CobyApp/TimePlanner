//
//  NoteRepository.swift
//  TimePlanner
//
//  Created by Coby on 10/21/24.
//

import Foundation

protocol NoteRepository {
    func createNote(note: NoteModel) async throws
    func updateNote(note: NoteModel) async throws
    func deleteNote(noteId: String) async throws
    func getNotes() async throws -> [NoteDTO]
}

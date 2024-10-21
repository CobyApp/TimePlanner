//
//  NoteRepositoryImpl.swift
//  TimePlanner
//
//  Created by Coby on 10/21/24.
//

import Foundation

import FirebaseAuth
import FirebaseFirestore

final class NoteRepositoryImpl: NoteRepository {
    
    private let db = Firestore.firestore()
    
    func createNote(note: NoteModel) async throws {
        guard let userId = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "No user logged in", code: 401, userInfo: nil)
        }
        
        let noteData: [String: Any] = [
            "id": note.id,
            "content": note.content,
            "createdAt": Timestamp(date: note.createdAt) // Timestamp로 변환
        ]
        
        try await self.db.collection("users")
            .document(userId)
            .collection("notes")
            .document(note.id)
            .setData(noteData)
    }
    
    func updateNote(note: NoteModel) async throws {
        guard let userId = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "No user logged in", code: 401, userInfo: nil)
        }
        
        let noteData: [String: Any] = [
            "content": note.content,
            "createdAt": Timestamp(date: note.createdAt) // Timestamp로 변환
        ]
        
        try await self.db.collection("users")
            .document(userId)
            .collection("notes")
            .document(note.id)
            .updateData(noteData)
    }
    
    func deleteNote(noteId: String) async throws {
        guard let userId = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "No user logged in", code: 401, userInfo: nil)
        }
        
        try await self.db.collection("users")
            .document(userId)
            .collection("notes")
            .document(noteId)
            .delete()
    }
    
    func getNotes() async throws -> [NoteDTO] {
        guard let userId = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "No user logged in", code: 401, userInfo: nil)
        }
        
        let snapshot = try await self.db.collection("users")
            .document(userId)
            .collection("notes")
            .getDocuments()
        
        let notes: [NoteDTO] = snapshot.documents.compactMap { document in
            let data = document.data()
            guard let id = data["id"] as? String,
                  let content = data["content"] as? String,
                  let createdAtTimestamp = data["createdAt"] as? Timestamp else { return nil }
            
            return NoteDTO(id: id, content: content, createdAt: createdAtTimestamp.dateValue()) // Timestamp에서 Date로 변환
        }
        
        return notes
    }
}

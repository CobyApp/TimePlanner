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
    
    // 특정 날짜의 년월에 해당하는 메모 목록 가져오기
    func getNotesForDate(_ date: Date) async throws -> [NoteDTO] {
        guard let userId = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "로그인된 사용자가 없습니다", code: 401, userInfo: nil)
        }
        
        // 주어진 날짜의 시작과 끝을 계산
        let calendar = Calendar.current
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date))!
        let endOfMonth = calendar.date(byAdding: .month, value: 1, to: startOfMonth)!
        
        // 메모 가져오기
        let noteSnapshot = try await self.db.collection("users")
            .document(userId)
            .collection("notes")
            .whereField("createdAt", isGreaterThanOrEqualTo: Timestamp(date: startOfMonth))
            .whereField("createdAt", isLessThan: Timestamp(date: endOfMonth))
            .getDocuments()
        
        // 필터링된 메모 목록 생성
        let filteredNotes: [NoteDTO] = noteSnapshot.documents.compactMap { document in
            let data = document.data()
            guard let id = data["id"] as? String,
                  let content = data["content"] as? String,
                  let createdAtTimestamp = data["createdAt"] as? Timestamp else { return nil }

            let createdAt = createdAtTimestamp.dateValue()
            return NoteDTO(id: id, content: content, createdAt: createdAt)
        }
        
        return filteredNotes
    }
}

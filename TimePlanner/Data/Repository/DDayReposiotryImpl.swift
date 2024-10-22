//
//  DDayReposiotryImpl.swift
//  TimePlanner
//
//  Created by Coby on 10/22/24.
//

import Foundation

import FirebaseAuth
import FirebaseFirestore

final class DDayRepositoryImpl: DDayRepository {
    
    private let db = Firestore.firestore()
    
    func createDDay(dDay: DDayModel) async throws {
        guard let userId = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "No user logged in", code: 401, userInfo: nil)
        }
        
        let dDayData: [String: Any] = [
            "id": dDay.id,
            "name": dDay.name,
            "dDate": Timestamp(date: dDay.dDate) // Timestamp로 변환
        ]
        
        try await self.db.collection("users")
            .document(userId)
            .collection("dDays")
            .document(dDay.id)
            .setData(dDayData)
    }
    
    func updateDDay(dDay: DDayModel) async throws {
        guard let userId = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "No user logged in", code: 401, userInfo: nil)
        }
        
        let dDayData: [String: Any] = [
            "name": dDay.name,
            "dDate": Timestamp(date: dDay.dDate) // Timestamp로 변환
        ]
        
        try await self.db.collection("users")
            .document(userId)
            .collection("dDays")
            .document(dDay.id)
            .updateData(dDayData)
    }
    
    func deleteDDay(dDayId: String) async throws {
        guard let userId = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "No user logged in", code: 401, userInfo: nil)
        }
        
        try await self.db.collection("users")
            .document(userId)
            .collection("dDays")
            .document(dDayId)
            .delete()
    }
    
    func getDDays() async throws -> [DDayDTO] {
        guard let userId = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "No user logged in", code: 401, userInfo: nil)
        }
        
        let snapshot = try await self.db.collection("users")
            .document(userId)
            .collection("dDays")
            .getDocuments()
        
        let dDays: [DDayDTO] = snapshot.documents.compactMap { document in
            let data = document.data()
            guard let id = data["id"] as? String,
                  let name = data["name"] as? String,
                  let dDateTimestamp = data["dDate"] as? Timestamp else { return nil }
            
            return DDayDTO(id: id, name: name, dDate: dDateTimestamp.dateValue()) // Timestamp에서 Date로 변환
        }
        
        return dDays
    }
}

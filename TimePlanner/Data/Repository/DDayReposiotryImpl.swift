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
    
    // 특정 년월의 dDate에 해당하는 D-Day 목록 가져오기
    func getDDaysForDate(_ date: Date) async throws -> [DDayDTO] {
        guard let userId = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "로그인된 사용자가 없습니다", code: 401, userInfo: nil)
        }
        
        // 주어진 날짜의 년과 월을 이용해 시작일과 종료일을 계산
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        
        // 해당 년월의 시작과 끝 날짜 계산
        let startOfMonth = calendar.date(from: DateComponents(year: year, month: month, day: 1))!
        let endOfMonth = calendar.date(byAdding: .month, value: 1, to: startOfMonth)!
        
        // D-Day 가져오기
        let snapshot = try await self.db.collection("users")
            .document(userId)
            .collection("dDays")
            .whereField("dDate", isGreaterThanOrEqualTo: Timestamp(date: startOfMonth))
            .whereField("dDate", isLessThan: Timestamp(date: endOfMonth))
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

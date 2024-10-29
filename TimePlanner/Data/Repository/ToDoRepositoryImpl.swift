//
//  ToDoRepositoryImpl.swift
//  TimePlanner
//
//  Created by Coby on 10/16/24.
//

import Foundation

import FirebaseAuth
import FirebaseFirestore

final class ToDoRepositoryImpl: ToDoRepository {
    
    private let db = Firestore.firestore()
    
    // 카테고리 생성
    func createCategory(category: CategoryModel) async throws {
        guard let userId = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "No user logged in", code: 401, userInfo: nil)
        }
        
        let categoryData: [String: Any] = [
            "id": category.id,
            "name": category.name,
            "color": category.color.rawValue
        ]
        
        try await self.db.collection("users")
            .document(userId)
            .collection("categories")
            .document(category.id)
            .setData(categoryData)
    }
    
    // 카테고리 수정
    func updateCategory(category: CategoryModel) async throws {
        guard let userId = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "No user logged in", code: 401, userInfo: nil)
        }
        
        let categoryData: [String: Any] = [
            "name": category.name,
            "color": category.color.rawValue
        ]
        
        try await self.db.collection("users")
            .document(userId)
            .collection("categories")
            .document(category.id)
            .updateData(categoryData)
    }
    
    // 카테고리 삭제
    func deleteCategory(categoryId: String) async throws {
        guard let userId = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "No user logged in", code: 401, userInfo: nil)
        }
        
        try await self.db.collection("users")
            .document(userId)
            .collection("categories")
            .document(categoryId)
            .delete()
    }
    
    // 카테고리 목록 가져오기
    func getCategories() async throws -> [CategoryDTO] {
        guard let userId = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "No user logged in", code: 401, userInfo: nil)
        }
        
        let snapshot = try await self.db.collection("users")
            .document(userId)
            .collection("categories")
            .getDocuments()
        
        var categories: [CategoryDTO] = []
        
        // 각 카테고리별로 할 일 목록 가져오기
        for document in snapshot.documents {
            let data = document.data()
            guard let id = data["id"] as? String,
                  let name = data["name"] as? String,
                  let color = data["color"] as? String else { continue }
            
            // 해당 카테고리의 할 일 목록 가져오기
            let toDoSnapshot = try await self.db.collection("users")
                .document(userId)
                .collection("categories")
                .document(id)
                .collection("items")
                .getDocuments()
            
            // 할 일 목록 생성
            let items: [ToDoItemDTO] = toDoSnapshot.documents.compactMap { itemDoc in
                let itemData = itemDoc.data()
                guard let itemId = itemData["id"] as? String,
                      let title = itemData["title"] as? String,
                      let isChecked = itemData["isChecked"] as? Bool,
                      let date = (itemData["date"] as? Timestamp)?.dateValue() else { return nil }
                
                return ToDoItemDTO(id: itemId, title: title, isChecked: isChecked, date: date)
            }
            
            // 카테고리와 해당 할 일들로 CategoryDTO 생성
            let categoryDTO = CategoryDTO(id: id, name: name, color: color, items: items)
            categories.append(categoryDTO)
        }
        
        return categories
    }
    
    // 할 일 생성
    func createToDoItem(categoryId: String, item: ToDoItemModel) async throws {
        guard let userId = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "No user logged in", code: 401, userInfo: nil)
        }
        
        let toDoData: [String: Any] = [
            "id": item.id,
            "title": item.title,
            "isChecked": item.isChecked,
            "date": item.date
        ]
        
        try await self.db.collection("users")
            .document(userId)
            .collection("categories")
            .document(categoryId)
            .collection("items")
            .document(item.id)
            .setData(toDoData)
    }
    
    // 할 일 수정
    func updateToDoItem(categoryId: String, item: ToDoItemModel) async throws {
        guard let userId = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "No user logged in", code: 401, userInfo: nil)
        }
        
        let toDoData: [String: Any] = [
            "title": item.title,
            "isChecked": item.isChecked,
            "date": item.date
        ]
        
        try await self.db.collection("users")
            .document(userId)
            .collection("categories")
            .document(categoryId)
            .collection("items")
            .document(item.id)
            .updateData(toDoData)
    }
    
    // 할 일 삭제
    func deleteToDoItem(categoryId: String, itemId: String) async throws {
        guard let userId = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "No user logged in", code: 401, userInfo: nil)
        }
        
        try await self.db.collection("users")
            .document(userId)
            .collection("categories")
            .document(categoryId)
            .collection("items")
            .document(itemId)
            .delete()
    }
    
    // 카테고리에 속한 할 일 목록 가져오기
    func getToDoItems(categoryId: String) async throws -> [ToDoItemDTO] {
        guard let userId = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "No user logged in", code: 401, userInfo: nil)
        }
        
        let snapshot = try await self.db.collection("users")
            .document(userId)
            .collection("categories")
            .document(categoryId)
            .collection("items")
            .getDocuments()
        
        let items: [ToDoItemDTO] = snapshot.documents.compactMap { document in
            let data = document.data()
            guard let id = data["id"] as? String,
                  let title = data["title"] as? String,
                  let isChecked = data["isChecked"] as? Bool,
                  let date = (data["date"] as? Timestamp)?.dateValue() else { return nil }
            
            return ToDoItemDTO(id: id, title: title, isChecked: isChecked, date: date)
        }
        
        return items
    }
    
    // 특정 날짜의 할 일들로 필터링된 모든 카테고리 가져오기
    func getCategoriesWithFilteredToDoItems(forDate date: Date) async throws -> [CategoryDTO] {
        guard let userId = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "No user logged in", code: 401, userInfo: nil)
        }
        
        // 날짜의 시작과 끝을 구함
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        // 카테고리 가져오기
        let categorySnapshot = try await self.db.collection("users")
            .document(userId)
            .collection("categories")
            .getDocuments()
        
        var categories: [CategoryDTO] = []
        
        // 각 카테고리별로 할 일 목록 가져오기 (특정 날짜로 필터링)
        for document in categorySnapshot.documents {
            let categoryData = document.data()
            guard let categoryId = categoryData["id"] as? String,
                  let name = categoryData["name"] as? String,
                  let color = categoryData["color"] as? String else { continue }
            
            // 해당 카테고리의 할 일 중 특정 날짜의 것들만 가져오기
            let toDoSnapshot = try await self.db.collection("users")
                .document(userId)
                .collection("categories")
                .document(categoryId)
                .collection("items")
                .whereField("date", isGreaterThanOrEqualTo: startOfDay)
                .whereField("date", isLessThan: endOfDay)
                .getDocuments()
            
            // 필터링된 할 일 목록 생성, 없으면 빈 배열로 처리
            let filteredItems: [ToDoItemDTO] = toDoSnapshot.documents.compactMap { itemDoc in
                let itemData = itemDoc.data()
                guard let id = itemData["id"] as? String,
                      let title = itemData["title"] as? String,
                      let isChecked = itemData["isChecked"] as? Bool,
                      let date = (itemData["date"] as? Timestamp)?.dateValue() else { return nil }
                
                return ToDoItemDTO(id: id, title: title, isChecked: isChecked, date: date)
            }
            
            // 카테고리와 해당 날짜의 할 일들로 CategoryDTO 생성
            let categoryDTO = CategoryDTO(id: categoryId, name: name, color: color, items: filteredItems)
            categories.append(categoryDTO)
        }
        
        return categories
    }
    
    // 할 일 체크 상태 업데이트
    func updateToDoItemCheckedStatus(categoryId: String, itemId: String, isChecked: Bool) async throws {
        guard let userId = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "No user logged in", code: 401, userInfo: nil)
        }
        
        let updateData: [String: Any] = [
            "isChecked": isChecked
        ]
        
        try await self.db.collection("users")
            .document(userId)
            .collection("categories")
            .document(categoryId)
            .collection("items")
            .document(itemId)
            .updateData(updateData)
    }
    
    // 특정 날짜의 년월에 해당하는 카테고리와 할 일 목록 가져오기
    func getCategoriesForDate(_ date: Date) async throws -> [CategoryDTO] {
        guard let userId = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "로그인된 사용자가 없습니다", code: 401, userInfo: nil)
        }
        
        // 주어진 날짜의 시작과 끝을 계산
        var calendar = Calendar.current
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date))!
        let endOfMonth = calendar.date(byAdding: .month, value: 1, to: startOfMonth)!
        
        // 카테고리 가져오기
        let categorySnapshot = try await self.db.collection("users")
            .document(userId)
            .collection("categories")
            .getDocuments()
        
        var categories: [CategoryDTO] = []
        
        // 각 카테고리별로 할 일 목록 가져오기 (특정 월로 필터링)
        for document in categorySnapshot.documents {
            let categoryData = document.data()
            guard let categoryId = categoryData["id"] as? String,
                  let name = categoryData["name"] as? String,
                  let color = categoryData["color"] as? String else { continue }
            
            // 해당 카테고리의 할 일 중 특정 월의 것들만 가져오기
            let toDoSnapshot = try await self.db.collection("users")
                .document(userId)
                .collection("categories")
                .document(categoryId)
                .collection("items")
                .whereField("date", isGreaterThanOrEqualTo: startOfMonth)
                .whereField("date", isLessThan: endOfMonth)
                .getDocuments()
            
            // 필터링된 할 일 목록 생성, 없으면 빈 배열로 처리
            let filteredItems: [ToDoItemDTO] = toDoSnapshot.documents.compactMap { itemDoc in
                let itemData = itemDoc.data()
                guard let id = itemData["id"] as? String,
                      let title = itemData["title"] as? String,
                      let isChecked = itemData["isChecked"] as? Bool,
                      let date = (itemData["date"] as? Timestamp)?.dateValue() else { return nil }
                
                return ToDoItemDTO(id: id, title: title, isChecked: isChecked, date: date)
            }
            
            // 카테고리와 해당 월의 할 일들로 CategoryDTO 생성
            let categoryDTO = CategoryDTO(id: categoryId, name: name, color: color, items: filteredItems)
            categories.append(categoryDTO)
        }
        
        return categories
    }
}

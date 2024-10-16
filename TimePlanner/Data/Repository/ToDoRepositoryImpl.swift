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
    
    func getCategories() async throws -> [CategoryDTO] {
        guard let userId = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "No user logged in", code: 401, userInfo: nil)
        }
        
        let snapshot = try await self.db.collection("users")
            .document(userId)
            .collection("categories")
            .getDocuments()
        
        let categories: [CategoryDTO] = snapshot.documents.compactMap { document in
            let data = document.data()
            guard let id = data["id"] as? String,
                  let name = data["name"] as? String,
                  let color = data["color"] as? String else { return nil }
            
            return CategoryDTO(id: id, name: name, color: color)
        }
        
        return categories
    }
}

//
//  DefaultDueDateRepository.swift
//  Poentjak
//
//  Created by Felicia Himawan on 02/10/24.
//

import Foundation
import FirebaseFirestore

class DefaultDueDateRepository: DueDateRepositoryProtocol {
    private let firestore = Firestore.firestore()
    
    func updateDueDate(userId: String, dueDate: Date) async throws {
        let documentRef = firestore.collection("users").document(userId)
        
        do {
            // Use Firestore's async function for updating the document
            try await documentRef.updateData([
                "dueDate": dueDate
            ])
            print("Due date successfully updated")
        } catch {
            // Handle and propagate any errors
            print("Error updating due date: \(error)")
            throw error
        }
    }
    
    
}

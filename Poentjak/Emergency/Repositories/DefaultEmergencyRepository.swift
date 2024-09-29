//
//  DefaultEmergencyRepository.swift
//  Poentjak
//
//  Created by Felicia Himawan on 27/09/24.
//

import Foundation
import FirebaseFirestore

class DefaultEmergencyRepository: EmergencyRepositoryProtocol{
    
    
    private let firestore = Firestore.firestore()
    
    func createEmergency(userId: String, with emergency: EmergencyModel) async throws {
        let collectionRef = firestore.collection("testSOS")
        
        do {
            let newDocReference: () = try collectionRef.document(userId).setData(from: emergency)
            print("Emergency stored with new document reference: \(newDocReference)")
        } catch {
            print(error)
            throw error
        }
    }
    
    
    func deleteEmergency(userId: String) async throws {
        let documentRef = firestore.collection("testSOS").document(userId)
        
        // Perform the delete operation
        try await documentRef.delete()
        
        print("Document with userId \(userId) has been deleted.")
        
    }
    
}



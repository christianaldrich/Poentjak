//
//  DefaultBatteryHealthRepository.swift
//  Poentjak
//
//  Created by Shan Havilah on 07/10/24.
//

import Foundation
import FirebaseFirestore

class UserStatusRepository: UserStatusRepositoryProtocol {
    private let firestore = Firestore.firestore()
    
    func updateStats(userId: String, batteryLevel: Int, lastSeen: Date, lastLocation: Location) async throws {
        let documentRef = firestore.collection("emergencyRequests").whereField("user.id", isEqualTo: userId).whereField("sessionDone", isEqualTo: false)

        do {
            let querySnapshot = try await documentRef.getDocuments()

            guard let document = querySnapshot.documents.first else {
                print("No document found for the specified userId")
                return
            }

            // Get the document ID to update
            let documentID = document.documentID

            // Perform the update on the specific document
            try await firestore.collection("sessions").document(documentID).updateData([
                "lastSeen": lastSeen,
                "lastLocation": [
                    "latitude": lastLocation.latitude,
                    "longitude": lastLocation.longitude
                ], // Assuming lastLocation is a custom type, so convert it to a dictionary
                "batteryHealth": batteryLevel
            ])
            
            print("Stats successfully updated for document: \(documentID)")
        } catch {
            print("Error updating stats: \(error)")
            throw error
        }
    }
}


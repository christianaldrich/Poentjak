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

    func createEmergency(with emergency: EmergencyModel) async throws {
        let documentRef = firestore.collection("emergencyRequests").document(emergency.id)
        
        do {
            let newDocReference: () = try documentRef.setData(from: emergency)

            print("Emergency stored with new document reference: \(newDocReference)")
        } catch {
            print(error)
            throw error
        }
    }
    
    
//    func deleteEmergency(userId: String) async throws {
//            let collectionRef = firestore.collection("emergencyRequests")
//            
//            // Query to find documents where the userId matches
//            let querySnapshot = try await collectionRef.whereField("userId", isEqualTo: userId).getDocuments()
//            
//            if querySnapshot.isEmpty {
//                print("No document found with userId \(userId) to delete.")
//                throw NSError(domain: "EmergencyRepositoryError", code: 404, userInfo: [NSLocalizedDescriptionKey: "No document found with userId \(userId)"])
//            }
//            
//            // Loop through documents and delete each one that matches
//            for document in querySnapshot.documents {
//                try await document.reference.delete()
//                print("Document with userId \(userId) has been deleted.")
//            }
//        }
//    
//    func fetchEmergency(userId: String, completion: @escaping (Result<EmergencyModel?, any Error>) -> Void) {
//        let collectionRef = firestore.collection("emergencyRequests")
//                
//                // Real-time Firestore listener
//                collectionRef.whereField("userId", isEqualTo: userId).addSnapshotListener { querySnapshot, error in
//                    if let error = error {
//                        completion(.failure(error))
//                        return
//                    }
//                    
//                    guard let document = querySnapshot?.documents.first else {
//                        print("No documents found for userId \(userId)")
//                        completion(.success(nil)) // Return nil if no document is found
//                        return
//                    }
//                    
//                    let data = document.data()
//                    let emergency = EmergencyModel(
//                        id: document.documentID,
//                        userId: data["userId"] as? String ?? "",
//                        trackId: data["trackId"] as? String ?? "",
//                        emergencyType: data["emergencyType"] as? String ?? "",
//                        status: data["status"] as? String ?? "",
//                        dueDate: (data["dueDate"] as? Timestamp)?.dateValue(),
//                        assignedRangers: data["assignedRangers"] as? [String] ?? [],
//                        lastLocation: {
//                            if let locationData = data["lastLocation"] as? [String: Any],
//                               let latitude = locationData["latitude"] as? Double,
//                               let longitude = locationData["longitude"] as? Double {
//                                return LocationModel(latitude: latitude, longitude: longitude)
//                            } else {
//                                return nil
//                            }
//                        }()
//                    )
//                    
//                    completion(.success(emergency))
//                }
//    }
    
}



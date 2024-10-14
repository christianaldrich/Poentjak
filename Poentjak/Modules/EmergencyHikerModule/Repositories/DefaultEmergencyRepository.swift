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
    
    func createEmergency(with emergency: EmergencyRequest) async throws {
        let emergencyDTO = EmergencyRequestMapper.mapToDTO(emergency) // Map to DTO
        //        let documentRef = firestore.collection("emergencyRequests").document(emergency.id)
        let documentRef = firestore.collection("sessions").document(emergency.id)
        
        
        do {
            try documentRef.setData(from: emergencyDTO) // Save the DTO in Firestore
            print("Emergency stored with new document ID: \(emergency.id)")
        } catch {
            print(error)
            throw error
        }
        
    }
    
    func updateSessionDone(userId: String, sessionDone: Bool) async throws {
        let collectionRef = firestore.collection("sessions")
        
        let querySnapshot = try await collectionRef
            .whereField("user.id", isEqualTo: userId)
            .whereField("sessionDone", isEqualTo: false)
            .getDocuments()
        
        guard let document = querySnapshot.documents.first else {
            throw NSError(domain: "EmergencyRepositoryError", code: 404, userInfo: [NSLocalizedDescriptionKey: "No emergency session found for user"])
        }
        
        do{
            // Update the sessionDone field
            try await document.reference.updateData([
                "sessionDone": sessionDone
            ])
            
            print("SessionDone updated to \(sessionDone) for user: \(userId)")
        } catch {
            print("Error updating session done: \(error)")
            throw error
        }
        
        
        
    }
    
    
    func updateDueDate(sessionId: String, dueDate: Date) async throws {
        let documentRef = firestore.collection("sessions").document(sessionId)
        
        do{
            try await documentRef.updateData([
                "dueDate": dueDate
            ])
            print("Due Date successfully updated, in repo")
        } catch {
            print("Error updating due date in repo: \(error)")
            throw error
        }
        
    }
    
    func updateStatusTypeEmergency(sessionId: String, emergencyStatus: String, emergencyType: String) async throws {
        let documentRef = firestore.collection("sessions").document(sessionId)
        
        do{
            try await documentRef.updateData([
                "emergencyStatus": emergencyStatus,
                "emergencyType": emergencyType

                
            ])
            print("successfully updated status & type, in repo")
        } catch {
            print("Error update status & repo in repo: \(error)")
            throw error
        }
    }
    
    
    func fetchEmergency(userId: String, completion: @escaping (Result<EmergencyRequest?, any Error>) -> Void) {
        let collectionRef = firestore.collection("sessions")
        
        collectionRef
            .whereField("user.id", isEqualTo: userId)
            .whereField("sessionDone", isEqualTo: false)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let document = querySnapshot?.documents.first else {
                    print("No documents found for userId \(userId)")
                    completion(.success(nil)) // Return nil if no document is found
                    return
                }
                
                do {
                    // Decode the Firestore document to EmergencyRequestDTO
                    let dto = try document.data(as: EmergencyRequestDTO.self)
                    
                    // Map the DTO to your domain model
                    let emergency = EmergencyRequestMapper.mapToDomain(dto)
                    
                    // Return the domain model
                    completion(.success(emergency))
                } catch {
                    print("Error decoding EmergencyRequestDTO: \(error)")
                    completion(.failure(error))
                }
            }
    }
    
    //    func updateDueDate(userId: String, dueDate: Date) async throws {
    //        let documentRef = firestore.collection("users").document(userId)
    //
    //        do {
    //            // Use Firestore's async function for updating the document
    //            try await documentRef.updateData([
    //                "dueDate": dueDate
    //            ])
    //            print("Due date successfully updated")
    //        } catch {
    //            // Handle and propagate any errors
    //            print("Error updating due date: \(error)")
    //            throw error
    //        }
    //    }
    
    //    func createEmergency(with emergency: EmergencyModel) async throws {
    //        let documentRef = firestore.collection("emergencyRequests").document(emergency.id)
    //
    //        do {
    //            let newDocReference: () = try documentRef.setData(from: emergency)
    //
    //            print("Emergency stored with new document reference: \(newDocReference)")
    //        } catch {
    //            print(error)
    //            throw error
    //        }
    //    }
    
    
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
    
    
    //        func fetchEmergency(userId: String, completion: @escaping (Result<EmergencyModel?, any Error>) -> Void) {
    //            let collectionRef = firestore.collection("emergencyRequests")
    //
    //
    //                    // Real-time Firestore listener
    //                    collectionRef.whereField("userId", isEqualTo: userId).addSnapshotListener { querySnapshot, error in
    //                        if let error = error {
    //                            completion(.failure(error))
    //                            return
    //                        }
    //
    //                        guard let document = querySnapshot?.documents.first else {
    //                            print("No documents found for userId \(userId)")
    //                            completion(.success(nil)) // Return nil if no document is found
    //                            return
    //                        }
    //
    //                        let data = document.data()
    //                        let emergency = EmergencyModel(
    //                            id: document.documentID,
    //                            userId: data["userId"] as? String ?? "",
    //                            trackId: data["trackId"] as? String ?? "",
    //                            emergencyType: data["emergencyType"] as? String ?? "",
    //                            status: data["status"] as? String ?? "",
    //                            dueDate: (data["dueDate"] as? Timestamp)?.dateValue(),
    //                            assignedRangers: data["assignedRangers"] as? [String] ?? [],
    //                            lastLocation: {
    //                                if let locationData = data["lastLocation"] as? [String: Any],
    //                                   let latitude = locationData["latitude"] as? Double,
    //                                   let longitude = locationData["longitude"] as? Double {
    //                                    return LocationModel(latitude: latitude, longitude: longitude)
    //                                } else {
    //                                    return nil
    //                                }
    //                            }()
    //                        )
    //
    //                        completion(.success(emergency))
    //                    }
    //        }
    
}



//
//  RangerEmergencyRequestRepository.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 01/10/24.
//

import Foundation
import Firebase
import FirebaseFirestore

protocol AdminEmergencyRequestRepositoryProtocol {
    func fetchEmergencyRequest(by id: String) async throws -> EmergencyRequest
    func updateEmergencyRequest(request: EmergencyRequest) async throws
    func addListenerToEmergencyRequest(by id: String, completion: @escaping (Result<EmergencyRequest?, Error>) -> Void)
    func updateEmergencyRequestToComplete(id: String) async throws
    
    
}

class DefaultAdminEmergencyRequestRepository: AdminEmergencyRequestRepositoryProtocol {
    
    private let firestore = Firestore.firestore()
    
    func fetchEmergencyRequest(by id: String) async throws -> EmergencyRequest {
        let docRef = firestore.collection("emergencyRequests").document(id)
        
        
        let document = try await docRef.getDocument()
        
        guard let data = document.data() else {
            throw NSError(domain: "EmergencyRequest", code: 404, userInfo: [NSLocalizedDescriptionKey: "Emergency request not found"])
        }
        
        let dto = try Firestore.Decoder().decode(EmergencyRequestDTO.self, from: data)
        return EmergencyRequestMapper.mapToDomain(dto)
        
        
        
    }
    
    func addListenerToEmergencyRequest(by id: String, completion: @escaping (Result<EmergencyRequest?, any Error>) -> Void) {
        let docRef = firestore.collection("emergencyRequests").document(id)
        docRef.addSnapshotListener { documentSnapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let documentSnapshot = documentSnapshot, documentSnapshot.exists else {
                print("No document found for id \(id)")
                completion(.success(nil)) // Return nil if no document is found
                return
            }
            
            do {
                // Decode the Firestore document to EmergencyRequestDTO
                let dto = try documentSnapshot.data(as: EmergencyRequestDTO.self)
                
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
    
    
    func updateEmergencyRequest(request: EmergencyRequest) async throws {
        let docRef = firestore.collection("emergencyRequests").document(request.id)
        do {
            try await docRef.updateData([
                "emergencyStatus": "ongoing",
                "assignedRangers": request.assignedRangers as Any, // add as any
            ])
            print("Document successfully updated")
        } catch {
            print("Error updating document: \(error)")
        }
    }
    
    func updateEmergencyRequestToComplete(id: String) async throws {
        let docRef = firestore.collection("emergencyRequests").document(id)
        do {
            try await docRef.updateData([
                "emergencyStatus": "completed",
                "sessionDone": true
            ])
        } catch {
            print("error update document complete")
        }
        
    }
    
    
}

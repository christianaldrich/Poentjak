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
    
    func updateEmergencyRequest(request: EmergencyRequest) async throws {
        let docRef = firestore.collection("emergencyRequests").document(request.id)
        do {
            try await docRef.updateData([
                "emergencyStatus": request.emergencyStatus.rawValue,
                "assignedRangers": request.assignedRangers,
            ])
            print("Document successfully updated")
        } catch {
            print("Error updating document: \(error)")
        }
    }
    
    
}

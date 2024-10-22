//
//  ActiveEmergencyRepository.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 03/10/24.
//

import Foundation
import FirebaseFirestore

protocol ActiveEmergencyRepositoryProtocol{
    func fetchEmergencyRequestByTrack(trackId: String, completion: @escaping([EmergencyRequestModel]) -> Void)
    func fetchCompletedRescue(completion: @escaping([EmergencyRequestModel]) -> Void)
}

struct ActiveEmergencyRepository : ActiveEmergencyRepositoryProtocol{
    let db = Firestore.firestore()
    private var listener: ListenerRegistration?
    
    func fetchEmergencyRequest(completion: @escaping([EmergencyRequestModel]) -> Void){
        db.collection("emergencyRequests")
        //            .whereField("status", isEqualTo: "pending")
            .addSnapshotListener{ snapshot, error in
                if let error = error {
                    print("Error fetching users: \(error)")
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    print("No users found")
                    return
                }
                let requests = documents.map { EmergencyRequestModel(dictionary: $0.data()) }
                
                print("\n\n\nREQUESTS: \(requests)")
                completion(requests)
                
            }
    }
    
    func fetchEmergencyRequestByTrack(trackId: String, completion: @escaping([EmergencyRequestModel]) -> Void){
        db.collection("emergencyRequests")

            .whereField("user.trackId", isEqualTo: trackId)
            .whereField("sessionDone", isEqualTo: false)
        
            .addSnapshotListener{ snapshot, error in
                if let error = error {
                    print("Error fetching emergencies: \(error)")
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    print("No active emergency in this track!")
                    return
                }
                let requests = documents.map { EmergencyRequestModel(dictionary: $0.data()) }
                
//                print("\n\n\nREQUESTS: \(requests)")
                completion(requests)
            }
    }
    
    func fetchDangerHikersInfo(id: String, completion: @escaping([UserModel]) -> Void){
        
        db.collection("users")
            .whereField("id", isEqualTo: id)
            .whereField("isAdmin", isEqualTo: false)
            .addSnapshotListener{ snapshot, error in
                if let error = error {
                    print("Error fetching users: \(error)")
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    print("No users found")
                    return
                }
                let requests = documents.map { UserModel(dictionary: $0.data()) }
                
                completion(requests)
                
            }
        
        
    }
    func confirmRescue(id: String, completion: @escaping([UserModel]) -> Void){
        db.collection("emergencyRequests")
            .document(id)
            .updateData([
                "emergencyStatus" : "danger"
            ]){error in
                if let error = error {
                    print("Error updating document: \(error)")
                } else {
                    print("Document successfully updated")
                }
            }
        
    }
    
    func updateEmergencyRequestToOverdue(id: String) async throws {
        
        let docRef = db.collection("emergencyRequests").document(id)
        do {
            try await docRef.updateData([
                "emergencyType": "overdue",
                "emergencyStatus": "danger"
            ])
            
        }
        catch {
            print(error)
            
        }
    }
    
    func fetchCompletedRescue(completion: @escaping([EmergencyRequestModel]) -> Void){
        db.collection("emergencyRequests")
            .whereField("sessionDone", isEqualTo: true)
            .whereField("emergencyStatus", isEqualTo: "completed")
        
            .addSnapshotListener{ snapshot, error in
                if let error = error {
                    print("Error fetching emergencies: \(error)")
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    print("No active emergency in this track!")
                    return
                }
                let requests = documents.map { EmergencyRequestModel(dictionary: $0.data()) }
                
//                print("\n\n\nREQUESTS: \(requests)")
                completion(requests)
            }
    }
    
    
    
}

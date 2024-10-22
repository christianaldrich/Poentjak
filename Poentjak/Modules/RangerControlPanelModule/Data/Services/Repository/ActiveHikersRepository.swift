//
//  ActiveHikersRepository.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 07/10/24.
//
import Foundation
import FirebaseFirestore

protocol ActiveHikersRepositoryProtocol {
    func fetchActiveHikers(trackId: String, completion: @escaping([EmergencyRequestModel]) -> Void)
    func updateHikerSession(userId: String) async throws
}

struct ActiveHikersRepository: ActiveHikersRepositoryProtocol{
    let db = Firestore.firestore()
    private var listener: ListenerRegistration?
    
    func fetchActiveHikers(trackId: String, completion: @escaping([EmergencyRequestModel]) -> Void){
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
    
    func updateHikerSession(userId : String) async throws{
        let collectionRef = db.collection("emergencyRequests")
        
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
                "sessionDone": true,
            ])
            print("Session updated from ranger!")
        } catch {
            print("Error updating session done: \(error)")
            throw error
        }
        
    }
}

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
}

struct ActiveHikersRepository: ActiveHikersRepositoryProtocol{
    let db = Firestore.firestore()
    private var listener: ListenerRegistration?
    
//    func fetchActiveHikers(completion: @escaping([EmergencyRequestModel]) -> Void){
//        db.collection("emergencyRequests")
//            .whereField("sessionDone", isEqualTo: false)
//            .addSnapshotListener{ snapshot, error in
//                if let error = error {
//                    print("Error fetching users: \(error)")
//                    
//                    return
//                }
//                
//                guard let documents = snapshot?.documents else {
//                    print("No users found")
//                    return
//                }
//                let requests = documents.map { EmergencyRequestModel(dictionary: $0.data()) }
//                
//                completion(requests)
//                
//            }
//    }
    
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
}

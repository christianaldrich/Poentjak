//
//  MountainsTracksRepository.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 08/10/24.
//

import Foundation
import FirebaseFirestore

protocol MountainsTracksRepositoryProtocol{
    func fetchMountainsTracks(completion: @escaping([MountainTracksModel]) -> Void)
}

struct MountainsTracksRepository: MountainsTracksRepositoryProtocol{
    let db = Firestore.firestore()
    private var listener: ListenerRegistration?
    
    func fetchMountainsTracks(completion: @escaping([MountainTracksModel]) -> Void){
        db.collection("mountains")
            .addSnapshotListener{ snapshot, error in
                if let error = error {
                    print("Error fetching users: \(error)")
                    
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    print("No users found")
                    return
                }
                let requests = documents.map { MountainTracksModel(dictionary: $0.data()) }
                print("\n\nData: \(requests)")
                completion(requests)
                
            }
    }
}

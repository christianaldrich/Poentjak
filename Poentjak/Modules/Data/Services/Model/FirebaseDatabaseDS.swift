//
//  FirebaseDatabaseDS.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 25/09/24.
//

import Foundation
import FirebaseFirestore

//protocol FirebaseDatabaseProtocol{
//    func fetchUsers(prompt: String) async throws -> String
//}

struct FirebaseDatabaseDS{
    
    
    let db = Firestore.firestore()
    private var listener: ListenerRegistration?
    
    func fetchUserInDanger(completion: @escaping([UserModel]) -> Void){
        
        db.collection("users")
            .whereField("isDanger", isEqualTo: true)
            .addSnapshotListener{ snapshot, error in
                if let error = error {
                    print("Error fetching users: \(error)")
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    print("No users found")
                    return
                }
                let users = documents.map { UserModel(dictionary: $0.data()) }
                
                completion(users)
                
            }
    }
    
    func confirmRescue(id: String, completion: @escaping([UserModel]) -> Void){
        db.collection("users")
            .document(id)
            .updateData([
//                "isDanger" : false,
                "isInRescue" : true
            ]){error in
                if let error = error {
                    print("Error updating document: \(error)")
                } else {
                    print("Document successfully updated")
                }
            }
        
    }
    
    
    func finishRescue(){
        
    }
    
}

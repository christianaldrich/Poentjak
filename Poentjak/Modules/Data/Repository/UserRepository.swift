//
//  UserRepository.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 25/09/24.
//

import Foundation
import FirebaseFirestore


//protocol UserRepository{
//    func fetchUsers() async throws -> String
//}

struct UserRepository{
    
    let db = Firestore.firestore()
    
    func fetchUserInDanger(completion: @escaping([UserModel]) -> Void){
        
        db.collection("users")
            .whereField("isDanger", isEqualTo: true)
            .getDocuments { snapshot, error in
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
    
    func confirmRescue(){
        
    }

}




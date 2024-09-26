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

class FirebaseDatabaseDS{
    
    
    let db = Firestore.firestore()
    
    @Published var users: UserModel?
    @Published var errorMessage: String?
    
    func fetchUsers() {
       
    }
}

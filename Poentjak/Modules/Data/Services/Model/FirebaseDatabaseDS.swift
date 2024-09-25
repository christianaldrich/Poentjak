//
//  FirebaseDatabaseDS.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 25/09/24.
//

import Foundation
import FirebaseFirestore

protocol FirebaseDatabaseProtocol{
    func fetchUsers(prompt: String) async throws -> String
}

class FirebaseDatabaseDS{
    let db = Firestore.firestore()
    
    @Published var users: UserRequest?
    
//    @Published var users: [UserRequest] = [] // If you expect multiple users
    
    
    func fetchUsers(documentId : String) {
        //        db.collection("users").getDocuments { (snapshot, error) in
        
        
        //            if let error = error {
        //                print("Error fetching data: \(error)")
        ////                self.errorMessage = "Error getting document: \(error.localizedDescription)"
        //            } else {
        //                for document in snapshot!.documents {
        //                    let data = document.data()
        //
        //    //                let coordinate = data["coordinate"] ?? (GeoPoint(latitude: 0.0, longitude: 0.0))
        //    //                let user = data["user"] as? String ?? "No Users"
        //
        //                    let name = data["name"] ?? "Unknown"
        //                    let age = data["age"] ?? 0
        //                    let isDanger = data["isDanger"] ?? false
        //                    let lastSeen =  data["lastSeen"] ?? GeoPoint(latitude: 0.0, longitude: 0.0)
        //
        //    //                print("Name: \(coordinate), User: \(user)")
        //
        //                    print("Name: \(name)\nAge: \(age)\nisDanger: \(isDanger)\nlastSeen: \(lastSeen)")
        //                }
        //            }
        //        }
        
        let docRef = db.collection("users").document(documentId)
        
        docRef.getDocument{ document, error in
            
            if let error = error as NSError? {
//                self.errorMessage = "Error getting document: \(error.localizedDescription)"
                print("Error fetching data: \(error)")
            }
            else{
                if let document = document{
                    do {
                        self.users = try document.data(as: UserRequest.self)
                    } catch {
                        print(error)
                    }
                }
            }
            
            
            
        }
        
        
    }
}

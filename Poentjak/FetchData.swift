//
//  FetchData.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 24/09/24.
//

import FirebaseFirestore

class FetchData{
    // Get a reference to the Firestore database
    let db = Firestore.firestore()

    // Fetch data from the "users" collection
    func fetchUsers() {
        db.collection("locations").getDocuments { (snapshot, error) in
            
//            print(snapshot as Any)
//            print(error as Any)
            if let error = error {
                print("Error fetching data: \(error)")
            } else {
                for document in snapshot!.documents {
                    let data = document.data()
                    
//                    print("Data: \(data)")
                    
                    let coordinate = data["coordinate"] ?? (GeoPoint(latitude: 0.0, longitude: 0.0))
                    let user = data["user"] as? String ?? "No Users"
                    print("Name: \(coordinate), User: \(user)")
                }
            }
        }
    }
}


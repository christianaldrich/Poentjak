//
//  RangerConfirmation.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 24/09/24.
//

import FirebaseFirestore

class RangerConfirmation{
    
    let db = Firestore.firestore()
    var currentId = 3
    
    func addData() {
        // Define the data to add
        let data: [String: Any] = [
            "name": "John Doe",
            "age": 30,
            "city": "New York",
            "coordinates" : GeoPoint(latitude: 0.1, longitude: 0.12)
        ]
        
        currentId += 1
        
        var docId = "location\(currentId)"
        
        // Add data to a collection named "users"
        db.collection("locations").document(docId).setData(data) { error in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("Document successfully written!")
            }
        }
    }
}

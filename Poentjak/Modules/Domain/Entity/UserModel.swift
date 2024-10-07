//
//  UserModel.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 26/09/24.
//

import Foundation
import FirebaseFirestore

struct UserModel{
    var age: Int
    var contactName: String
    var contactNumber: String
    var gender: String
    var height: Int
    var id: String
    var medicalRecord: String
    var name: String
    var profileUrl: String
    var trackId: String
    var weight: Int
    
    init(dictionary: [String: Any]) {
        
        self.age = dictionary["age"] as? Int ?? 0
        self.contactName = dictionary["contactName"] as? String ?? ""
        self.contactNumber = dictionary["contactNumber"] as? String ?? ""
        self.gender = dictionary["gender"] as? String ?? ""
        self.height = dictionary["height"] as? Int ?? 0
        self.id = dictionary["id"] as? String ?? ""
        self.medicalRecord = dictionary["medicalRecord"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        self.profileUrl = dictionary["profileUrl"] as? String ?? ""
        self.trackId = dictionary["trackId"] as? String ?? ""
        self.weight = dictionary["weight"] as? Int ?? 0
        
    }
}


//cari parsing json

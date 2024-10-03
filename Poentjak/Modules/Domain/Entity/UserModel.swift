//
//  UserModel.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 26/09/24.
//

import Foundation
import FirebaseFirestore

struct UserModel{
    var id:String
    var fullname: String
    var age: Int
    var gender: String
    var height: Int
    var weight: Int
    
    init(dictionary: [String: Any]) {
        
        self.id = dictionary["id"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.gender = dictionary["gender"] as? String ?? ""
        self.age = dictionary["age"] as? Int ?? 0
        self.height = dictionary["height"] as? Int ?? 0
        self.weight = dictionary["weight"] as? Int ?? 0
        
    }
}


//cari parsing json

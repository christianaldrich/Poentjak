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
    var name: String
    var age: Int
    var gender: String
    var height: Int
    var isDanger: Bool
    var isRescued: Bool
    var isFinished: Bool
    var isInRescue: Bool
    var lastSeen: GeoPoint
    var weight: Int
    
    init(dictionary: [String: Any]) {
        
        self.id = dictionary["id"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        self.gender = dictionary["gender"] as? String ?? ""
        self.age = dictionary["age"] as? Int ?? 0
        self.height = dictionary["height"] as? Int ?? 0
        self.isDanger = dictionary["isDanger"] as? Bool ?? false
        self.isRescued = dictionary["isRescued"] as? Bool ?? false
        self.isFinished = dictionary["isFinished"] as? Bool ?? false
        self.isInRescue = dictionary["isInRescue"] as? Bool ?? false
        self.lastSeen = dictionary["lastSeen"] as? GeoPoint ?? GeoPoint(latitude: 0.0, longitude: 0.0)
        self.weight = dictionary["weight"] as? Int ?? 0
        
    }
}


//cari parsing json

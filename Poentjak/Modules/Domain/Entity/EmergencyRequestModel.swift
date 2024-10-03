//
//  EmergencyRequestModel.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 03/10/24.
//


import Foundation
import FirebaseFirestore

struct EmergencyRequestModel{
    var assignedRangers: [String]
    var dueDate: Date
    var emergencyType: String
    var id: String
    var lastLocation: GeoPoint
    var status: String
    var trackId: String
    var userId: String
    
    init(dictionary: [String: Any]) {
        
        self.assignedRangers = dictionary["assignedRangers"] as? [String] ?? [""]
        self.dueDate = dictionary["dueDate"] as? Date ?? Date()
        self.emergencyType = dictionary["emergencyType"] as? String ?? ""
        self.id = dictionary["id"] as? String ?? ""
        self.lastLocation = dictionary["lastLocation"] as? GeoPoint ?? GeoPoint(latitude: 0, longitude: 0)
        self.status = dictionary["status"] as? String ?? ""
        self.trackId = dictionary["trackId"] as? String ?? ""
        self.userId = dictionary["userId"] as? String ?? ""
    }
}


//cari parsing json

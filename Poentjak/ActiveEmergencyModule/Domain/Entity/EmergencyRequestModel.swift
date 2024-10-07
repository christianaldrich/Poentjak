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
    var batteryHealth: Int
    var dueDate: Date
    var emergencyStatus: String
    var emergencyType: String
    var id: String
    var lastLocation: lastLocationModel?
    var sessionDone: Bool
    var user: UserModel?
    
    init(dictionary: [String: Any]) {
        
        self.assignedRangers = dictionary["assignedRangers"] as? [String] ?? [""]
        self.batteryHealth = dictionary["batteryHealth"] as? Int ?? 0
        self.dueDate = dictionary["dueDate"] as? Date ?? Date()
        self.emergencyStatus = dictionary["emergencyStatus"] as? String ?? ""
        self.emergencyType = dictionary["emergencyType"] as? String ?? ""
        self.id = dictionary["id"] as? String ?? ""
        
        if let lastLocationMap = dictionary["lastLocation"] as? [String: Any] {
            self.lastLocation = lastLocationModel(dictionary: lastLocationMap)
        } else {
            self.lastLocation = nil
        }
        
        self.sessionDone = dictionary["sessiondone"] as? Bool ?? false
        
        
        if let userMap = dictionary["user"] as? [String: Any] {
            self.user = UserModel(dictionary: userMap)
        } else {
            self.user = nil
        }
        
        
    }
}

struct lastLocationModel{
    var latitude: Double
    var longitude: Double
    
    init(dictionary: [String: Any]) {
        
        self.latitude = dictionary["latitude"] as? Double ?? 0.0
        self.longitude = dictionary["longitude"] as? Double ?? 0.0
    }
}


//cari parsing json

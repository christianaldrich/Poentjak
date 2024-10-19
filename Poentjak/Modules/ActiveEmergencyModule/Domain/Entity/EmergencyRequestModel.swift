//
//  EmergencyRequestModel.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 03/10/24.
//


import Foundation
import FirebaseFirestore

struct EmergencyRequestModel: Identifiable ,Hashable{
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
        if let timestamp = dictionary["dueDate"] as? Timestamp {
            self.dueDate = timestamp.dateValue()
        } else {
            self.dueDate = Date()
        }
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
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)  // Use the 'id' as a unique identifier
    }
    static func == (lhs: EmergencyRequestModel, rhs: EmergencyRequestModel) -> Bool {
        return lhs.id == rhs.id
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

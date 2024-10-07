//
//  EmergencyModel.swift
//  Poentjak
//
//  Created by Felicia Himawan on 27/09/24.
//

import Foundation

struct EmergencyModel: Codable{
    let id: String
    let trackId: String?
    let emergencyType: String?
    let emergencyStatus: String
    let dueDate: Date
    let assignedRangers: [String]
    let lastLocation: LocationModel?
    let batteryHealth: Int
    let lastSeen: Date?
    let sessionDone: Bool
    let user: User
    
//    let id: String
//    let userId: String
//    let trackId: String?
//    let emergencyType: String
//    let status: String
//    let dueDate: Date?
//    let assignedRangers: [String]
//    let lastLocation: LocationModel?
    
}

struct LocationModel: Codable{
    let latitude: Double
    let longitude: Double
}

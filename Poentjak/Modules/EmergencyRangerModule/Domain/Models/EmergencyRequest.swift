//
//  EmergencyRequest.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 29/09/24.
//

import Foundation

struct EmergencyRequest {
    let id: String
    let emergencyType: EmergencyType?
    var emergencyStatus: EmergencyStatus
    var assignedRangers: [String]?
    var batteryHealth: Int?
    var lastLocation: Location?
    var lastSeen: Date?
    var dueDate: Date
    var sessionDone: Bool
    var user: User
}

enum EmergencyStatus: String {
    case safe
    case danger
    case ongoing
    case completed
}

enum EmergencyType: String {
    case hipo
    case overdue
    case lost
    case injury
}

//
//  EmergencyRequestDTO.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 29/09/24.
//

import Foundation

struct EmergencyRequestDTO: Codable {
    let id: String
    let emergencyType: String
    let emergencyStatus: String
    let assignedRangers: [String]
    let batteryHealth: Int
    let lastLocation: LocationDTO
    let lastSeen: Date
    let dueDate: Date
    let sessionDone: Bool
    let user: UserDTO
}

struct EmergencyRequestMapper {
    static func mapToDomain(_ dto: EmergencyRequestDTO) -> EmergencyRequest {
        return EmergencyRequest(
            id: dto.id,
            emergencyType: EmergencyType(rawValue: dto.emergencyType) ?? .hipo,
            emergencyStatus: EmergencyStatus(rawValue: dto.emergencyStatus) ?? .safe,
            assignedRangers: dto.assignedRangers,
            batteryHealth: dto.batteryHealth,
            lastLocation: LocationMapper.mapToDomain(dto.lastLocation),
            lastSeen: dto.lastSeen,
            dueDate: dto.dueDate,
            sessionDone: dto.sessionDone,
            user: UserMapper.mapToDomain(dto.user)
        )
    }
    
    static func mapToDTO(_ model: EmergencyRequest) -> EmergencyRequestDTO {
        return EmergencyRequestDTO(
            id: model.id,
            emergencyType: model.emergencyType.rawValue,
            emergencyStatus: model.emergencyStatus.rawValue,
            assignedRangers: model.assignedRangers,
            batteryHealth: model.batteryHealth,
            lastLocation: LocationMapper.mapToDTO(model.lastLocation),
            lastSeen: model.lastSeen,
            dueDate: model.dueDate,
            sessionDone: model.sessionDone,
            user: UserMapper.mapToDTO(model.user)
        )
    }
}


//
//  UserDTO.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 06/10/24.
//

import Foundation

struct UserDTO: Codable {
    let id: String
    let name: String
    let age: Int
    let gender: String
    let height: Double
    let weight: Double
    let contactName: String
    let contactNumber: String
    let profileURL: String
    let trackId: String
    let medicalRecord: String?
}

struct UserMapper {
    static func mapToDomain(_ dto: UserDTO) -> User {
        return User(
            id: dto.id,
            name: dto.name,
            age: dto.age,
            gender: dto.gender,
            height: dto.height,
            weight: dto.weight, 
            contactName: dto.contactName,
            contactNumber: dto.contactNumber,
            medicalRecord: dto.medicalRecord,
            profileURL: dto.profileURL,
            trackId: dto.trackId
        )
    }
    
    static func mapToDTO(_ model: User) -> UserDTO {
        return UserDTO(
            id: model.id,
            name: model.name,
            age: model.age,
            gender: model.gender,
            height: model.height,
            weight: model.weight, 
            contactName: model.contactName,
            contactNumber: model.contactNumber,
            profileURL: model.profileURL,
            trackId: model.trackId, 
            medicalRecord: model.medicalRecord
        )
    }
}


//
//  RangerDTO.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 29/09/24.
//

import Foundation

struct RangerDTO: Codable{
    var id: String
    let name: String
    let available: Bool
    let trackId: String
}

struct RangerMapper {
    static func mapToDomain(_ dto: RangerDTO) -> Ranger {
        return Ranger(id: dto.id, name: dto.name, available: dto.available, trackId: dto.trackId)
    }
    
    static func mapToDTO(_ model: Ranger) -> RangerDTO {
        return RangerDTO(id: model.id, name: model.name, available: model.available, trackId: model.trackId)
    }
}


//
//  LocationDTO.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 01/10/24.
//

import Foundation

struct LocationDTO: Codable {
    var latitude: Double
    var longitude: Double

    init(from dict: [String: Any]) {
        self.latitude = dict["latitude"] as? Double ?? 0.0
        self.longitude = dict["longitude"] as? Double ?? 0.0
    }
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

struct LocationMapper {
    static func mapToDomain(_ dto: LocationDTO) -> Location {
        return Location(latitude: dto.latitude, longitude: dto.longitude)
    }
    
    static func mapToDTO(_ model: Location) -> LocationDTO {
        return LocationDTO(latitude: model.latitude, longitude: model.longitude)
    }
}

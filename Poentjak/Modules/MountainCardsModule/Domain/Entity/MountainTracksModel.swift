//
//  MountainModel.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 08/10/24.
//

import Foundation

struct MountainTracksModel: Identifiable, Hashable{
    var description: String
    var height: Int
    var id: String
    var location: Location
    var name: String
    var tracks: [String]
    
    init(dictionary: [String: Any]) {
        self.description = dictionary["description"] as? String ?? ""
        self.height = dictionary["height"] as? Int ?? 0
        self.id = dictionary["id"] as? String ?? ""
        self.location = dictionary["location"] as? Location ?? Location(latitude: 0, longitude: 0)
        self.name = dictionary["name"] as? String ?? ""
        self.tracks = dictionary["tracks"] as? [String] ?? [""]
    }
    
    
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    static func == (lhs: MountainTracksModel, rhs: MountainTracksModel) -> Bool {
            return lhs.id == rhs.id
        }

}

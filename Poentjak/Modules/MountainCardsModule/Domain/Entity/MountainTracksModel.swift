//
//  MountainModel.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 08/10/24.
//

import Foundation

struct MountainTracksModel: Identifiable, Hashable {
    var id: String
    var name: String
    var description: String
    var height: Int
    var location: Location
    var tracks: [String] // Change to hold track IDs instead of TrackMountain
    var imageURL: String

    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        self.description = dictionary["description"] as? String ?? ""
        self.height = dictionary["height"] as? Int ?? 0
        self.location = dictionary["location"] as? Location ?? Location(latitude: 0, longitude: 0)
        self.imageURL = dictionary["imageURL"] as? String ?? ""
        
        // Assuming tracks are represented as IDs in the Firestore
        self.tracks = dictionary["tracks"] as? [String] ?? []
    }


    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: MountainTracksModel, rhs: MountainTracksModel) -> Bool {
        return lhs.id == rhs.id
    }
}


//
//  TrackModel.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 03/11/24.
//


import Foundation

struct TrackMountain: Identifiable, Hashable, Decodable {
    var id: String // Unique identifier for the track
    var name: String
    var imageURL: String
    var desc: String
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String ?? UUID().uuidString // Generate a unique ID if not present
        self.name = dictionary["name"] as? String ?? ""
        self.imageURL = dictionary["imageURL"] as? String ?? ""
        self.desc = dictionary["desc"] as? String ?? ""
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: TrackMountain, rhs: TrackMountain) -> Bool {
        return lhs.id == rhs.id
    }
}

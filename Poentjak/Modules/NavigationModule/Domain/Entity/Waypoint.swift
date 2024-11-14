//
//  Waypoint.swift
//  MacroSprint_1
//
//  Created by Shan Havilah on 29/09/24.
//

import Foundation
import CoreLocation

enum WaypointCategory {
    case emergency
    case post
    case summit
}

struct Waypoint: Identifiable {
    let id = UUID()
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
    let elevation: CLLocationDistance
    let name: String
    let desc: String
    let idx: Int
    let imageName: String
    let checkPointStatus: String
    let category: WaypointCategory // Add category property
}

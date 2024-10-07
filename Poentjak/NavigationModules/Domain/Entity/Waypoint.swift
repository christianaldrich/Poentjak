//
//  Waypoint.swift
//  MacroSprint_1
//
//  Created by Shan Havilah on 29/09/24.
//

import Foundation
import CoreLocation

struct Waypoint: Identifiable {
    let id = UUID()
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
    let elevation: CLLocationDistance
    let name: String
}

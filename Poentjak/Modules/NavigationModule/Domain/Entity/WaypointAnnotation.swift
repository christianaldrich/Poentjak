//
//  WaypointAnnotation.swift
//  Poentjak
//
//  Created by Shan Havilah on 14/11/24.
//

import Foundation
import MapKit
import CoreLocation

class WaypointAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let waypoint: Waypoint

    init(waypoint: Waypoint) {
        self.coordinate = CLLocationCoordinate2D(latitude: waypoint.latitude, longitude: waypoint.longitude)
        self.title = waypoint.name
        self.waypoint = waypoint
    }
}

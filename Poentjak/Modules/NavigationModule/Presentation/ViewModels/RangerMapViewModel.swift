//
//  RangerMapViewModel.swift
//  Poentjak
//
//  Created by Shan Havilah on 16/10/24.
//

import CoreLocation
import MapKit

class RangerMapViewModel: ObservableObject {
    @Published var region = MKCoordinateRegion()
    let gpxParser = GPXParser()
    
    let locationManager = LocationManager()
    let fileName: String
    //let userLastLocation: Location
    
    init(fileName: String) {
        self.fileName = fileName
        gpxParser.parseGPX(fileName: fileName)
        //self.userLastLocation = userLastLocation
        setupRegionTrack()
    }
    
    func setupRegionTrack() {
        if let trackPoints = gpxParser.parsedTrack?.points, !trackPoints.isEmpty {
            let totalLat = trackPoints.reduce(0.0) { $0 + $1.latitude }
            let totalLon = trackPoints.reduce(0.0) { $0 + $1.longitude }
            let centerLat = totalLat / Double(trackPoints.count)
            let centerLon = totalLon / Double(trackPoints.count)
            region.center = CLLocationCoordinate2D(latitude: centerLat, longitude: centerLon)
            region.span = MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)
        }
    }
    
    func setupRegionUser() {
        if let location = locationManager.lastKnownLocation {
            region.center = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            region.span = MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)
        }

    }
}

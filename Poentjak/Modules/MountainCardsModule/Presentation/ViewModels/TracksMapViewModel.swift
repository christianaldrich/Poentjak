//
//  TracksMapViewModel.swift
//  Poentjak
//
//  Created by Shan Havilah on 08/11/24.
//

import CoreLocation
import MapKit

class TracksMapViewModel: ObservableObject {
    @Published var region = MKCoordinateRegion()
    let gpxParser = GPXParser()
    
    let locationManager = LocationManager()
    @Published var fileName: String
    //let userLastLocation: Location
    
    init(fileName: String) {
        self.fileName = fileName
        gpxParser.parseGPX(fileName: fileName)
        //self.userLastLocation = userLastLocation
        setupRegionTrackSouth()
    }
    
    func setupRegionTrackSouth() {
        if let trackPoints = gpxParser.parsedTrack?.points, !trackPoints.isEmpty {
            let totalLat = trackPoints.reduce(0.0) { $0 + $1.latitude }
            let totalLon = trackPoints.reduce(0.0) { $0 + $1.longitude }
            let centerLat = totalLat / Double(trackPoints.count) + 0.03
            let centerLon = totalLon / Double(trackPoints.count)
            region.center = CLLocationCoordinate2D(latitude: centerLat, longitude: centerLon)
            region.span = MKCoordinateSpan(latitudeDelta: 0.06, longitudeDelta: 0.06)
        }
    }
    
    func setupRegionTrackNorth() {
        if let trackPoints = gpxParser.parsedTrack?.points, !trackPoints.isEmpty {
            let totalLat = trackPoints.reduce(0.0) { $0 + $1.latitude }
            let totalLon = trackPoints.reduce(0.0) { $0 + $1.longitude }
            let centerLat = totalLat / Double(trackPoints.count) + 0.03
            let centerLon = totalLon / Double(trackPoints.count)
            region.center = CLLocationCoordinate2D(latitude: centerLat, longitude: centerLon)
            region.span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        }
    }
}

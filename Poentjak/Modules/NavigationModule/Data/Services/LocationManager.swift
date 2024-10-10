//
//  LocationManager.swift
//  macroTest1
//
//  Created by Singgih Tulus Makmud on 16/09/24.
//

import Foundation
import CoreLocation

// LocationManager: Manages user location and speed updates
final class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    @Published var lastKnownLocation: CLLocationCoordinate2D?
    @Published var currentSpeed: CLLocationSpeed = 0.0  // Store user's speed
    @Published var totalDistance: CLLocationDistance = 0.0 // Total distance traveled
    @Published var currentElevation: CLLocationDistance = 0.0 // Current elevation
    private var manager = CLLocationManager()
    private var previousLocation: CLLocation?
    
    var onLocationUpdate: (() -> Void)?  // Callback to notify location updates

    override init() {
        super.init()
        manager.delegate = self
        // manager.desiredAccuracy = kCLLocationAccuracyBest
        checkLocationAuthorization()
    }

    func checkLocationAuthorization() {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            print("Location restricted/denied")
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
            lastKnownLocation = manager.location?.coordinate
            currentSpeed = manager.location?.speed ?? 0.0  // Get initial speed
            currentElevation = manager.location?.altitude ?? 0.0 // Get initial elevation
        @unknown default:
            print("Unknown location authorization")
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        lastKnownLocation = location.coordinate
        currentSpeed = location.speed  // Update speed with latest location data
        currentElevation = location.altitude // Update elevation

        // Calculate distance traveled
        if let previousLocation = previousLocation {
            let distance = location.distance(from: previousLocation)
            totalDistance += distance
        }
        previousLocation = location
        
        onLocationUpdate?()  // Notify about location update
    }
    
    // New method to reset total distance
    func resetTotalDistance() {
        totalDistance = 0.0
    }
}

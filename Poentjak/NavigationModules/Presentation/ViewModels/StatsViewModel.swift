//
//  StatsViewModel.swift
//  MacroSprint_1
//
//  Created by Shan Havilah on 03/10/24.
//

import SwiftUI
import CoreLocation
import MapKit

class StatsViewModel: ObservableObject {
    @Published var region = MKCoordinateRegion()
    @Published var isNavigating = false
    @Published var startTime: Date? = nil
    @Published var elapsedTime: TimeInterval = 0.0
    @Published var isOnTrack = false
    @Published var closestPointDistance: Double = 0.0
    @Published var dots: [MKCircle] = [] // Array to store user location dots
    @Published var lastSignalLocation = CLLocationCoordinate2D()
    
    private var timer: Timer?
    private var dotTimer: Timer? // Timer to draw dots
    
    let gpxParser = GPXParser()
    let locationManager = LocationManager()
    let networkManager = NetworkManager()
    
    init() {
        gpxParser.parseGPX(fileName: "breeze-apple")
        setupRegionUser()
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

    func startTimer() {
        startTime = Date()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if let startTime = self.startTime {
                self.elapsedTime = Date().timeIntervalSince(startTime)
                self.updateTrackStatus()
            }
        }
        
        // Timer to add dots every 5 seconds if there's a connection
        dotTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
            if self.networkManager.isConnected {
                self.addDot()
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        dotTimer?.invalidate()
        dotTimer = nil
        startTime = nil
        elapsedTime = 0.0
        dots.removeAll()
    }
    
    func addDot() {
        guard let location = locationManager.lastKnownLocation else { return }
        let dot = MKCircle(center: location, radius: 5.0)
        lastSignalLocation = location // update lastSignalUser
        dots.append(dot)
    }
    
    // Update track status (on/off track)
    private func updateTrackStatus() {
        if let userLocation = locationManager.lastKnownLocation {
            if let closestPoint = closestPointOnTrack(userLocation: userLocation, track: gpxParser.parsedTrack?.points ?? []) {
                closestPointDistance = distanceBetween(userLocation, closestPoint)
                isOnTrack = closestPointDistance <= 5.0
            }
        }
    }
    
    // Function to calculate distance between two points
    func distanceBetween(_ coord1: CLLocationCoordinate2D, _ coord2: CLLocationCoordinate2D) -> CLLocationDistance {
        let loc1 = CLLocation(latitude: coord1.latitude, longitude: coord1.longitude)
        let loc2 = CLLocation(latitude: coord2.latitude, longitude: coord2.longitude)
        return loc1.distance(from: loc2)
    }

    // Function to find the closest point on the track to the user
    func closestPointOnTrack(userLocation: CLLocationCoordinate2D, track: [CLLocationCoordinate2D]) -> CLLocationCoordinate2D? {
        var closestPoint: CLLocationCoordinate2D?
        var smallestDistance: CLLocationDistance = Double.greatestFiniteMagnitude
        
        for point in track {
            let distance = distanceBetween(userLocation, point)
            if distance < smallestDistance {
                smallestDistance = distance
                closestPoint = point
            }
        }
        return closestPoint
    }

    // Modified function to calculate ETA with elevation
    func calculateETA(to waypoint: CLLocationCoordinate2D, waypointElevation: CLLocationDistance, userLocation: CLLocationCoordinate2D, userElevation: CLLocationDistance, speed: CLLocationSpeed) -> Double? {
        let horizontalDistance = distanceBetween(userLocation, waypoint)  // Horizontal distance in meters
        let elevationDifference = waypointElevation - userElevation       // Elevation difference in meters
        
        // Calculate 3D distance using Pythagorean theorem
        let totalDistance = sqrt(pow(horizontalDistance, 2) + pow(elevationDifference, 2))
        
        // Calculate ETA if speed is greater than 0
        if speed > 0 {
            let etaInSeconds = totalDistance / speed  // ETA in seconds based on total distance
            return etaInSeconds / 60  // Convert to minutes
        } else {
            return nil  // If speed is 0, return nil
        }
    }
    
}

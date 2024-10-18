//
//  UserNavigateViewModel.swift
//  MacroSprint_1
//
//  Created by Shan Havilah on 03/10/24.
//

import SwiftUI
import CoreLocation
import MapKit
import Combine

class UserNavigateViewModel: ObservableObject {
    
    let gpxParser = GPXParser()
    let locationManager = LocationManager()
    let networkManager = NetworkManager()
    
    let useCase = UserStatusUseCase(userRepository: DefaultUserRepository(), userStatusRepository: UserStatusRepository())
    
    @Published var region = MKCoordinateRegion()
    @Published var isNavigating = false
    @Published var closestPointDistance: Double = 0.0
    @Published var dots: [MKCircle] = [] // Array to store user location dots
    @Published var currentWaypointIndex = 0 // Track the current waypoint
    @Published var isReverseNavigation = false // New state to track reverse navigation
    @Published var isSOS: Bool = false
    @Published var etaValues: [String] = []
    
    private var cancellables = Set<AnyCancellable>()
    private var dotTimer: Timer? // Timer to draw dots
    
    @State var fileName: String
    
    init(fileName: String) {
        self.fileName = fileName
        gpxParser.parseGPX(fileName: fileName)
        setupRegionUser()
        
        // Set up location update callback
        locationManager.onLocationUpdate = { [weak self] in
            self?.checkIfUserPassedWaypoint()  // Check if the user passed the waypoint
            self?.updateETAs()
        }
        
        // Subscribe to SOS status updates
        SOSManager.shared.$isSOS
            .receive(on: RunLoop.main) // Ensure updates happen on the main thread
            .assign(to: \.isSOS, on: self)
            .store(in: &cancellables)
    }
    
    var nearestWarung: Waypoint? {
        guard let userLocation = locationManager.lastKnownLocation else { return nil }
        return closestPointOnTrack(userLocation: userLocation, track: gpxParser.parsedWaypointsWarung.map { CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude) })
            .flatMap { warungLocation in
                gpxParser.parsedWaypointsWarung.first { warung in
                    warung.latitude == warungLocation.latitude && warung.longitude == warungLocation.longitude
                }
            }
    }
    
    func updateTrackId(_ newFileName: String) {
            self.fileName = newFileName
            gpxParser.parseGPX(fileName: newFileName)
            print("\n\n\nUpdate Track ID: \(fileName)")
            print("\n\n\nNEWFILENAME Update Track ID: \(newFileName)")
            setupRegionTrack()  // Reset the region based on the new track
        locationManager.onLocationUpdate = { [weak self] in
            self?.checkIfUserPassedWaypoint()  // Check if the user passed the waypoint
            self?.updateETAs()
        }
    }
    
    //Dynamic fileName
    
    
    
    func updateETAs() {
        // Clear previous ETA values
        etaValues.removeAll()
        
        for waypoint in gpxParser.parsedWaypoints {
            if let userLocation = locationManager.lastKnownLocation {
                let eta = calculateETA(
                    to: CLLocationCoordinate2D(latitude: waypoint.latitude, longitude: waypoint.longitude),
                    waypointElevation: waypoint.elevation,
                    userLocation: userLocation,
                    userElevation: locationManager.currentElevation,
                    speed: locationManager.currentSpeed
                )
                
                // Format ETA as a string
                if let etaValue = eta {
                    let etaString = String(format: "%.1f min", etaValue)
                    etaValues.append("\(waypoint.name): \(etaString)")
                } else {
                    etaValues.append("\(waypoint.name): N/A")
                }
            } else {
                etaValues.append("\(waypoint.name): N/A")
            }
        }
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
        // Timer to add dots every 5 seconds if there's a connection
        dotTimer = Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) { _ in
            if self.networkManager.isConnected{
                Task {
                    await self.addDot()
                }
            }
        }
    }
    
    func stopTimer() {
        dotTimer?.invalidate()
        dotTimer = nil
        dots.removeAll()
    }
    
    func addDot() async {
        guard let location = locationManager.lastKnownLocation else { return }
        let dot = MKCircle(center: location, radius: 5.0)
        
        let lastLocation = Location(latitude: location.latitude, longitude: location.longitude)
        let lastSeen = Date()
        let batteryHealth = updateBatteryLevel()
        
        do {
            try await useCase.updateStats(batteryLevel: batteryHealth, lastSeen: lastSeen, lastLocation: lastLocation)
        } catch {
            print("error")
        }
        
        // Ensure that the UI update happens on the main thread
        DispatchQueue.main.async {
            print("DOTS ADDED")
            self.dots.append(dot)
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
    
    private func updateBatteryLevel() -> Int {
        UIDevice.current.isBatteryMonitoringEnabled = true
        let batteryLevelFloat = UIDevice.current.batteryLevel
        UIDevice.current.isBatteryMonitoringEnabled = false
        let batteryHealth = Int(batteryLevelFloat * 100) // Convert to percentage
        return batteryHealth
    }
    
    // Modified checkIfUserPassedWaypoint to handle reverse logic
    func checkIfUserPassedWaypoint() {
        guard !isReverseNavigation else {
            if currentWaypointIndex >= 0 {
                let currentWaypoint = gpxParser.parsedWaypointsPos[currentWaypointIndex]
                if let userLocation = locationManager.lastKnownLocation {
                    let distanceToWaypoint = distanceBetween(userLocation, CLLocationCoordinate2D(latitude: currentWaypoint.latitude, longitude: currentWaypoint.longitude))
                    
                    if distanceToWaypoint < 15.0 {
                        currentWaypointIndex -= 1 // Move to previous waypoint
                    }
                }
            }
            return
        }
        
        // Forward navigation logic
        guard currentWaypointIndex < gpxParser.parsedWaypointsPos.count else {
            isReverseNavigation = true // Start reverse journey
            currentWaypointIndex = gpxParser.parsedWaypointsPos.count - 1
            return
        }
        
        let currentWaypoint = gpxParser.parsedWaypointsPos[currentWaypointIndex]
        if let userLocation = locationManager.lastKnownLocation {
            let distanceToWaypoint = distanceBetween(userLocation, CLLocationCoordinate2D(latitude: currentWaypoint.latitude, longitude: currentWaypoint.longitude))
            
            if distanceToWaypoint < 15.0 {
                currentWaypointIndex += 1 // Move to next waypoint
            }
        }
    }
    
}

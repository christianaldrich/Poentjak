//
//  MKMapViewRepresentable.swift
//  CobaMap
//
//  Created by Shan Havilah on 06/11/24.
//


import SwiftUI
import MapKit

struct MKMapViewRepresentable: UIViewRepresentable {
    let mapView = MKMapView()

    func makeUIView(context: Context) -> MKMapView {
        mapView.showsUserLocation = true  // Enable user location
        mapView.userTrackingMode = .follow  // Center the map on the user's location
        mapView.delegate = context.coordinator  // Assign the delegate to respond to map events
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        guard let userLocation = uiView.userLocation.location else { return }

        // Only center the map once
        if !context.coordinator.hasCentered {
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: userLocation.coordinate.latitude - 0.004, // Shift upward
                    longitude: userLocation.coordinate.longitude
                ),
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01) // Adjust span as needed
            )
            uiView.setRegion(region, animated: true)
            context.coordinator.hasCentered = true  // Mark as centered
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MKMapViewRepresentable
        var hasCentered = false  // Track if centering has been done

        init(_ parent: MKMapViewRepresentable) {
            self.parent = parent
        }
    }
}

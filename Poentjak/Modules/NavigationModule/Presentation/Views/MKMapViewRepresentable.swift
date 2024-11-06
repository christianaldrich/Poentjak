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
        // You can update the map view settings here if needed.
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MKMapViewRepresentable
        
        init(_ parent: MKMapViewRepresentable) {
            self.parent = parent
        }
    }
}

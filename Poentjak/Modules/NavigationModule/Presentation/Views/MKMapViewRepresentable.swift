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
        
        // Add custom recenter button
        let recenterButton = UIButton(type: .system)
        let recenterImage = UIImage(systemName: "location.fill")  // SF Symbol
        recenterButton.setImage(recenterImage, for: .normal)
        recenterButton.tintColor = UIColor(.primaryGreen500)
        recenterButton.backgroundColor = UIColor(.neutralWhiteBiancaWhite)
        recenterButton.layer.cornerRadius = 8
        recenterButton.translatesAutoresizingMaskIntoConstraints = false
        recenterButton.addTarget(context.coordinator, action: #selector(context.coordinator.recenterTapped), for: .touchUpInside)
        
        mapView.addSubview(recenterButton)
        
        // Add toggle map type button
        let toggleButton = UIButton(type: .system)
        let toggleImage = UIImage(systemName: "map.fill")  // SF Symbol
        toggleButton.setImage(toggleImage, for: .normal)
        toggleButton.tintColor = UIColor(.primaryGreen500)
        toggleButton.backgroundColor = UIColor(.neutralWhiteBiancaWhite)
        toggleButton.layer.cornerRadius = 8
        toggleButton.translatesAutoresizingMaskIntoConstraints = false
        toggleButton.addTarget(context.coordinator, action: #selector(context.coordinator.toggleMapTypeTapped), for: .touchUpInside)
        
        mapView.addSubview(toggleButton)
        
        // Layout buttons
        NSLayoutConstraint.activate([
            // Recenter button in the middle
            recenterButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -20),
            recenterButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 270),
            recenterButton.widthAnchor.constraint(equalToConstant: 40),
            recenterButton.heightAnchor.constraint(equalToConstant: 40),
            
            // Toggle button at the top-right corner
            toggleButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -20),
            toggleButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 220),
            toggleButton.widthAnchor.constraint(equalToConstant: 40),
            toggleButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        // No changes needed in updateUIView
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MKMapViewRepresentable
        
        private var isSatelliteView = false  // Track the current map type
        
        init(_ parent: MKMapViewRepresentable) {
            self.parent = parent
        }
        
        @objc func recenterTapped() {
            guard let userLocation = parent.mapView.userLocation.location else { return }
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude - 0.003, longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
            parent.mapView.setRegion(region, animated: true)
        }
        
        @objc func toggleMapTypeTapped() {
            isSatelliteView.toggle()
            parent.mapView.mapType = isSatelliteView ? .satellite : .standard
        }
    }
}

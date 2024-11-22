//
//  MapView.swift
//  CobaGPX
//
//  Created by Shan Havilah on 24/09/24.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    var waypoints: [Waypoint]
    var track: Track?
    var showsUserLocation: Bool
    var dots: [MKCircle]
    @State var fileName: String?
    let mapView = MKMapView(frame: .zero)

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        private var isSatelliteView = false

        init(_ parent: MapView) {
            self.parent = parent
        }

        // Render overlays (track and dots)
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            
            
            if let polyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(polyline: polyline)
                renderer.strokeColor = UIColor.yellow
                renderer.lineWidth = 3
                return renderer
            } else if let circle = overlay as? MKCircle {
                let renderer = MKCircleRenderer(circle: circle)
                renderer.fillColor = UIColor(.accentBlue)
                renderer.strokeColor = UIColor(.primaryDarkGreen)
                renderer.lineWidth = 3
                return renderer
            }
            return MKOverlayRenderer()
        }
        
        // Custom view for annotations
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard let waypointAnnotation = annotation as? WaypointAnnotation else { return nil }
            
            let identifier = "WaypointAnnotation"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKAnnotationView
            
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
            } else {
                annotationView?.annotation = annotation
            }

            // Set the image based on waypoint category
            switch waypointAnnotation.waypoint.category {
            case .emergency:
                annotationView?.image = UIImage(named: "Icons/map/i_m_warung")
            case .post:
                annotationView?.image = UIImage(named: "Icons/map/i_m_checkpoint")
            case .summit:
                annotationView?.image = UIImage(named: "Icons/map/i_m_summit")
            }
            
            return annotationView
        }
        
        @objc func recenterTapped() {
            guard let userLocation = parent.mapView.userLocation.location else { return }
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude - 0.0025, longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
            parent.mapView.setRegion(region, animated: true)
        }
        
        @objc func toggleMapTypeTapped() {
            isSatelliteView.toggle()
            parent.mapView.mapType = isSatelliteView ? .satellite : .standard
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> MKMapView {
        
        mapView.delegate = context.coordinator
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = showsUserLocation
        mapView.userTrackingMode = .follow
        // mapView.showsUserTrackingButton = true

        // Add GPX track as a polyline overlay
        if let trackPoints = track?.points {
            let coordinates = trackPoints.map { CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude) }
            let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
            mapView.addOverlay(polyline)
        }
        
        let annotations = waypoints.map { waypoint in
            WaypointAnnotation(waypoint: waypoint)
        }
        mapView.addAnnotations(annotations)
        
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
            recenterButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 600),
            recenterButton.widthAnchor.constraint(equalToConstant: 40),
            recenterButton.heightAnchor.constraint(equalToConstant: 40),
            
            // Toggle button at the top-right corner
            toggleButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -20),
            toggleButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 550),
            toggleButton.widthAnchor.constraint(equalToConstant: 40),
            toggleButton.heightAnchor.constraint(equalToConstant: 40)
        ])

        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        // uiView.setRegion(region, animated: true)

        // Remove existing dots and add new dots as circle overlays
        // uiView.removeOverlays(uiView.overlays.filter { $0 is MKCircle })
        uiView.addOverlays(dots)
        
        // uiView.showsUserLocation = showsUserLocation // Ensure user location is shown

        // Add waypoints as annotations
//        uiView.removeAnnotations(uiView.annotations)
//        let annotations = waypoints.map { waypoint -> MKPointAnnotation in
//            let annotation = MKPointAnnotation()
//            annotation.coordinate = CLLocationCoordinate2D(latitude: waypoint.latitude, longitude: waypoint.longitude)
//            annotation.title = waypoint.name
//            return annotation
//        }
//        uiView.addAnnotations(annotations)
    }
}

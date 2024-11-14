//
//  TracksMapView.swift
//  Poentjak
//
//  Created by Shan Havilah on 08/11/24.
//

import SwiftUI
import MapKit

struct TracksMapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    var waypoints: [Waypoint]
    var track: Track?
    var showsUserLocation: Bool
    // @State private var annotationsAdded = false

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: TracksMapView

        init(_ parent: TracksMapView) {
            self.parent = parent
        }

        // Render overlays (track and dots)
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(polyline: polyline)
                renderer.strokeColor = UIColor.yellow
                renderer.lineWidth = 3
                return renderer
            }
             else if let circle = overlay as? MKCircle {
                let renderer = MKCircleRenderer(circle: circle)
                renderer.fillColor = UIColor.red.withAlphaComponent(0.5)
                renderer.strokeColor = UIColor.red
                renderer.lineWidth = 1
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
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.delegate = context.coordinator
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = showsUserLocation
        // mapView.showsUserTrackingButton = true

        // Enable the User Location Tracking Button (the button to recenter the map)
        // mapView.showsUserTrackingButton = true
        
        // Add GPX track as a polyline overlay
        if let trackPoints = track?.points {
            let coordinates = trackPoints.map { CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude) }
            let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
            mapView.addOverlay(polyline)
        }
        
        // Add waypoints annotations once when the map is first created
        //if !annotationsAdded {
            let annotations = waypoints.map { waypoint in
                WaypointAnnotation(waypoint: waypoint)
            }
            mapView.addAnnotations(annotations)
            //annotationsAdded = true
        //}

        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        //uiView.setRegion(region, animated: true)

        // Remove existing dots and add new dots as circle overlays
        // uiView.removeOverlays(uiView.overlays.filter { $0 is MKCircle })
        // uiView.addOverlays(dots)
        
 //       uiView.showsUserLocation = showsUserLocation // Ensure user location is shown
//
//        // Add waypoints as annotations
//        uiView.removeAnnotations(uiView.annotations)
//        let annotations = waypoints.map { waypoint in
//            WaypointAnnotation(waypoint: waypoint) // Accessing additional data (e.g., category, description) from Waypoint
//        }
//        uiView.addAnnotations(annotations)
    }
}

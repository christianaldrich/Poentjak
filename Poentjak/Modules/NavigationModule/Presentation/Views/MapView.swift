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

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

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
                renderer.fillColor = UIColor.blue.withAlphaComponent(0.5)
                renderer.strokeColor = UIColor.red
                renderer.lineWidth = 2
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
        mapView.showsUserTrackingButton = true

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

        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        // uiView.setRegion(region, animated: true)

        // Remove existing dots and add new dots as circle overlays
        uiView.removeOverlays(uiView.overlays.filter { $0 is MKCircle })
        uiView.addOverlays(dots)
        
        uiView.showsUserLocation = showsUserLocation // Ensure user location is shown

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

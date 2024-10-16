//
//  RangerMapView.swift
//  CobaGPX
//
//  Created by Shan Havilah on 15/10/24.
//

import SwiftUI
import MapKit

struct RangerMapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    var waypoints: [Waypoint]
    var track: Track?
    var showsUserLocation: Bool
    var userLastLocation: Location
    // var dots: [MKCircle]
    // @State var fileName: String?

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: RangerMapView

        init(_ parent: RangerMapView) {
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

        // Add GPX track as a polyline overlay
        if let trackPoints = track?.points {
            let coordinates = trackPoints.map { CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude) }
            let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
            mapView.addOverlay(polyline)
        }

        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        //uiView.setRegion(region, animated: true)

        // Remove existing dots and add new dots as circle overlays
        uiView.removeOverlays(uiView.overlays.filter { $0 is MKCircle })
        // uiView.addOverlays(dots)
        
        uiView.showsUserLocation = showsUserLocation // Ensure user location is shown

        // Add waypoints as annotations
        uiView.removeAnnotations(uiView.annotations)
        let annotations = waypoints.map { waypoint -> MKPointAnnotation in
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: waypoint.latitude, longitude: waypoint.longitude)
            annotation.title = waypoint.name
            return annotation
        }
        uiView.addAnnotations(annotations)
        
        // Convert userLastLocation to CLLocationCoordinate2D
        let userLastLocationCoordinate = CLLocationCoordinate2D(latitude: userLastLocation.latitude, longitude: userLastLocation.longitude)
        
        // Add a circle for userLastLocation
        let circle = MKCircle(center: userLastLocationCoordinate, radius: 10) // Set the radius of the circle in meters
        uiView.addOverlay(circle)
    }
}

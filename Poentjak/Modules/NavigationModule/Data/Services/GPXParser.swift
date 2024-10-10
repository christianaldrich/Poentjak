//
//  GPXParser.swift
//  MacroSprint_1
//
//  Created by Shan Havilah on 30/09/24.
//

import Foundation
import CoreLocation

class GPXParser: NSObject, XMLParserDelegate {
    private var waypoints: [Waypoint] = []
    private var trackPoints: [CLLocationCoordinate2D] = []
    private var waypointsPos: [Waypoint] = []
    private var waypointsWarung: [Waypoint] = []

    private var currentElement = ""
    private var latitude: CLLocationDegrees?
    private var longitude: CLLocationDegrees?
    private var elevation: CLLocationDistance = 0.0
    private var waypointName = ""

    var parsedWaypoints: [Waypoint] {
        return waypoints
    }

    var parsedTrack: Track? {
        return trackPoints.isEmpty ? nil : Track(points: trackPoints)
    }
    
    var parsedWaypointsWarung: [Waypoint] {
        return waypointsWarung
    }
    
    var parsedWaypointsPos: [Waypoint] {
        return waypointsPos
    }

    // Start parsing the GPX file
    func parseGPX(fileName: String) {
        if let path = Bundle.main.url(forResource: fileName, withExtension: "gpx"),
           let parser = XMLParser(contentsOf: path) {
            parser.delegate = self
            parser.parse()
        }
    }

    // XMLParser Delegate Methods
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        
        if elementName == "wpt" || elementName == "trkpt" {
            if let latString = attributeDict["lat"], let lonString = attributeDict["lon"] {
                latitude = CLLocationDegrees(latString)
                longitude = CLLocationDegrees(lonString)
            }
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let trimmedString = string.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if currentElement == "ele" {
            if let elevationValue = CLLocationDistance(trimmedString) {
                elevation = elevationValue
            }
        } else if currentElement == "name" {
            waypointName += trimmedString
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "wpt" {
            if let lat = latitude, let lon = longitude {
                let waypoint = Waypoint(latitude: lat, longitude: lon, elevation: elevation, name: waypointName)
                
                // Check if the waypoint name contains "Warung"
                if waypointName.localizedCaseInsensitiveContains("Warung") {
                    waypointsWarung.append(waypoint)
                } else {
                    waypointsPos.append(waypoint)
                }
                
                waypoints.append(waypoint) // Append to the main waypoints array
            }
            resetWaypointData()
        } else if elementName == "trkpt" {
            if let lat = latitude, let lon = longitude {
                let trackPoint = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                trackPoints.append(trackPoint)
            }
            resetTrackPointData()
        }
    }

    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("Parsing error: \(parseError.localizedDescription)")
    }
    
    // Reset waypoint data after each waypoint element is parsed
    private func resetWaypointData() {
        latitude = nil
        longitude = nil
        elevation = 0.0
        waypointName = ""
    }

    // Reset track point data after each track point element is parsed
    private func resetTrackPointData() {
        latitude = nil
        longitude = nil
    }
}

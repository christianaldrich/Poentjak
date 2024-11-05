//
//  TracksRepository.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 03/11/24.
//

import Foundation
import FirebaseFirestore

protocol TracksRepositoryProtocol {
    func fetchTracks(by ids: [String], completion: @escaping ([TrackMountain]) -> Void)
}

struct TracksRepository: TracksRepositoryProtocol {
    let db = Firestore.firestore()
    
    func fetchTracks(by ids: [String], completion: @escaping ([TrackMountain]) -> Void) {
        // Create a query for fetching tracks by IDs
        db.collection("tracks")
            .whereField(FieldPath.documentID(), in: ids) // Use the document ID to filter the results
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("Error fetching tracks: \(error)")
                    completion([]) // Return an empty array in case of an error
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    print("No tracks found for the given IDs.")
                    completion([]) // Return an empty array if no documents are found
                    return
                }
                
                // Map the documents to TrackMountain models
                let tracks = documents.compactMap { document -> TrackMountain? in
                    do {
                        // Decode the Firestore document to TrackMountain
                        return try document.data(as: TrackMountain.self)
                    } catch {
                        print("Error decoding TrackMountain: \(error)")
                        return nil
                    }
                }
                
                // Return the fetched tracks
                completion(tracks)
            }
        
    }
}

//
//  RangerRepository.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 01/10/24.
//

import Foundation
import Firebase
import FirebaseFirestore

protocol RangerRepositoryProtocol {
    func fetchRangersByTrack(trackId: String) async throws -> [Ranger]
    func fetchRangersByIds(_ rangerIds: [String]) async throws -> [Ranger]
    func updateRangerAvailability(rangers: [Ranger], available: Bool) async throws
    func createRangersForTrack(_ ranger: Ranger) async throws -> Ranger
    func editRangers(_ ranger: Ranger) async throws -> Ranger
    func deleteRangers(_ ranger: Ranger) async throws
}

class DefaultRangerRepository: RangerRepositoryProtocol {
   
    private let firestore = Firestore.firestore()
    
    func fetchRangersByTrack(trackId: String) async throws -> [Ranger] {
        let snapshot = try await firestore.collection("rangers")
            .whereField("trackId", isEqualTo: trackId)
            .getDocuments()
        
        return snapshot.documents.compactMap { document in
            let dto = try? Firestore.Decoder().decode(RangerDTO.self, from: document.data())
            return dto.map {RangerMapper.mapToDomain($0)}
        }
    }
    
    func fetchRangersByIds(_ rangerIds: [String]) async throws -> [Ranger] {
        // Check if rangerIds is empty
        guard !rangerIds.isEmpty else {
            // Return an empty array or throw an error, depending on your preference
            return []
        }

        let snapshot = try await firestore.collection("rangers")
            .whereField(FieldPath.documentID(), in: rangerIds)
            .getDocuments()

        return snapshot.documents.compactMap { document in
            let dto = try? Firestore.Decoder().decode(RangerDTO.self, from: document.data())
            return dto.map { RangerMapper.mapToDomain($0) }
        }
    }

    
    func updateRangerAvailability(rangers: [Ranger], available: Bool) async throws {
        for ranger in rangers {
            try await firestore.collection("rangers").document(ranger.id).updateData([
                "available": available
            ])
        }
    }
    
    func createRangersForTrack(_ ranger: Ranger) async throws -> Ranger {

        let docID = firestore.collection("rangers").document().documentID
        var dto = RangerMapper.mapToDTO(ranger)
        dto.id = docID
        try firestore.collection("rangers").document(docID).setData(from: dto)

        return Ranger(id: docID, name: ranger.name, available: ranger.available, trackId: ranger.trackId)
    }
    
    func editRangers(_ ranger: Ranger) async throws -> Ranger {
        try await firestore.collection("rangers").document(ranger.id).updateData(["name": ranger.name])
        return ranger
    }
    
    func deleteRangers(_ ranger: Ranger) async throws {
        do {
            try await firestore.collection("rangers").document(ranger.id).delete()
          print("Document successfully removed!")
        } catch {
          print("Error removing document: \(error)")
        }
    }
    
}

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
    func createRangersForTrack(_ ranger: Ranger) throws -> Ranger
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
    
    func createRangersForTrack(_ ranger: Ranger) throws -> Ranger {
        let dto = RangerMapper.mapToDTO(ranger)
        let docRef = try firestore.collection("rangers").addDocument(from: dto)
        return Ranger(id: docRef.documentID, name: ranger.name, available: ranger.available, trackId: ranger.trackId)
    }
    
}

//
//  TracksUseCase.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 03/11/24.
//

import Foundation

protocol TracksUseCaseProtocol {
    func fetchTracks(by ids: [String], completion: @escaping ([TrackMountain]) -> Void)
}

class TracksUseCase: TracksUseCaseProtocol {
    private let tracksRepository: TracksRepositoryProtocol

    init(tracksRepository: TracksRepositoryProtocol) {
        self.tracksRepository = tracksRepository
    }

    func fetchTracks(by ids: [String], completion: @escaping ([TrackMountain]) -> Void) {
        tracksRepository.fetchTracks(by: ids) { tracks in
            completion(tracks)
        }
    }
}


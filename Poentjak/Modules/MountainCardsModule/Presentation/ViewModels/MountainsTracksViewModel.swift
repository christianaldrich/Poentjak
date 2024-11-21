//
//  MountainsTracksViewModel.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 08/10/24.
//

import Foundation

class MountainsTracksViewModel: ObservableObject {
    @Published var mountainsTracks: [MountainTracksModel] = []
    @Published var selectedTracks: [TrackMountain] = [] // Add this to store selected tracks

    private let mountainsTracksUseCase: MountainsTracksUseCaseProtocol
    private let tracksUseCase: TracksUseCaseProtocol // Add TracksUseCaseProtocol

    @Published var isPresenting = false
    @Published var selectedTrackLocation: String = ""
    
    @Published var selectedMountain: MountainTracksModel?
    
    @Published var isShowingSelectTrackModal = false


    init(mountainsTracksUseCase: MountainsTracksUseCaseProtocol, tracksUseCase: TracksUseCaseProtocol) {
        self.mountainsTracksUseCase = mountainsTracksUseCase
        self.tracksUseCase = tracksUseCase // Initialize the tracks use case
        fetchMountainsTracks()
    }

    func fetchMountainsTracks() {
        mountainsTracksUseCase.fetchMountainsTracks { [weak self] mountains in
            DispatchQueue.main.async {
                self?.mountainsTracks = mountains
                
                // Fetch tracks for all the fetched mountains
                let allTrackIds = mountains.flatMap { $0.tracks } // Collect all track IDs
                self?.fetchTracksForSelectedMountain(trackIds: allTrackIds) // Fetch tracks
            }
        }
    }


    func fetchTracksForSelectedMountain(trackIds: [String]) {
        tracksUseCase.fetchTracks(by: trackIds) { [weak self] tracks in
            DispatchQueue.main.async {
                self?.selectedTracks = tracks // Store fetched tracks
                print(self?.selectedTracks ?? "kosong")
            }
        }
    }

    func toggleIsPresenting() {
        isPresenting.toggle()
    }
}

//
//  MountainsTracksViewModel.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 08/10/24.
//

import Foundation

class MountainsTracksViewModel: ObservableObject{
    @Published var mountainsTracks: [MountainTracksModel] = []
    
    private let mountainsTracksUseCase: MountainsTracksUseCaseProtocol
    
    @Published var isPresenting = false
    @Published var selectedTrackLocation: String = ""
    
    init(mountainsTracksUseCase: MountainsTracksUseCaseProtocol) {
        self.mountainsTracksUseCase = mountainsTracksUseCase
        fetchMountainsTracks()
    }
    func fetchMountainsTracks(){
        mountainsTracksUseCase.fetchMountainsTracks{ [weak self] mountains in
            DispatchQueue.main.async{
                self?.mountainsTracks = mountains
            }
            
        }
    }
    
    func toggleIsPresenting(){
        isPresenting.toggle()
    }
    
}

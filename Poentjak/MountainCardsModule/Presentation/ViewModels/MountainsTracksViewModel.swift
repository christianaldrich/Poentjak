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
}

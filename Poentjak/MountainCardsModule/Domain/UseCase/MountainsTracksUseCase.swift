//
//  MountainsTracksUseCase.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 08/10/24.
//
import Foundation

protocol MountainsTracksUseCaseProtocol{
    func fetchMountainsTracks(completion: @escaping ([MountainTracksModel]) -> Void)
}

class MountainsTracksUseCase: MountainsTracksUseCaseProtocol{
    private let mountainsTracksRepository: MountainsTracksRepositoryProtocol
    
    init(mountainsTracksRepository: MountainsTracksRepositoryProtocol) {
        self.mountainsTracksRepository = mountainsTracksRepository
    }
    
    func fetchMountainsTracks(completion: @escaping ([MountainTracksModel]) -> Void) {
        mountainsTracksRepository.fetchMountainsTracks{ requests in
            completion(requests)
        }
    }
}

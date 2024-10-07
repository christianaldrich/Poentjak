//
//  AddRangerUseCase.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 02/10/24.
//

import Foundation

protocol AddRangerUseCaseProtocol {
    func execute(_ ranger: Ranger) async throws -> Ranger
}

class AddRangerUseCase: AddRangerUseCaseProtocol {
    private let repository: DefaultRangerRepository
    
    init(repository: DefaultRangerRepository) {
        self.repository = repository
    }
    
    func execute(_ ranger: Ranger) async throws -> Ranger {
        return try repository.createRangersForTrack(ranger)
    }
    
    
}

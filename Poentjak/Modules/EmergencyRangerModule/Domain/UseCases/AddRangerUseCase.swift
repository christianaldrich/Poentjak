//
//  AddRangerUseCase.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 02/10/24.
//

import Foundation

protocol RangerUseCaseProtocol {
    func addRanger(_ ranger: Ranger) async throws -> Ranger
    func editRanger(_ ranger: Ranger) async throws -> Ranger
    func deleteRanger(_ ranger: Ranger) async throws
}

class RangerUseCase: RangerUseCaseProtocol {
    
    private let repository: DefaultRangerRepository
    
    init(repository: DefaultRangerRepository) {
        self.repository = repository
    }
    
    func addRanger(_ ranger: Ranger) async throws -> Ranger {
        return try await repository.createRangersForTrack(ranger)
    }
    
    func editRanger(_ ranger: Ranger) async throws -> Ranger {
        return try await repository.editRangers(ranger)
    }
    
    func deleteRanger(_ ranger: Ranger) async throws {
        try await repository.deleteRangers(ranger)
    }
}


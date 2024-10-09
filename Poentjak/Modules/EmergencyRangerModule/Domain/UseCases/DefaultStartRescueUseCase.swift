//
//  StartRescueUseCase.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 02/10/24.
//

import Foundation

protocol StartRescueUseCaseProtocol {
    func fetchEmergencyRequest(emergencyRequest id: String) async throws -> (EmergencyRequest, [Ranger])
    func assignRangersToEmergency(emergencyRequest id: String, rangerIds: [String]) async throws
}

class DefaultStartRescueUseCase: StartRescueUseCaseProtocol {
    
    private let emergencyRequestRepository: DefaultAdminEmergencyRequestRepository
    private let rangerRepository: DefaultRangerRepository
    
    init(emergencyRequestRepository: DefaultAdminEmergencyRequestRepository, rangerRepository: DefaultRangerRepository) {
        self.emergencyRequestRepository = emergencyRequestRepository
        self.rangerRepository = rangerRepository
    }
    
    func fetchEmergencyRequest(emergencyRequest id: String) async throws -> (EmergencyRequest, [Ranger]) {
        let emergencyRequest = try await emergencyRequestRepository.fetchEmergencyRequest(by: id)
        let availableRangers = try await rangerRepository.fetchRangersByTrack(trackId: emergencyRequest.user.trackId)
        return (emergencyRequest, availableRangers)
    }
    
    func assignRangersToEmergency(emergencyRequest id: String, rangerIds: [String]) async throws {
        var emergencyRequest = try await emergencyRequestRepository.fetchEmergencyRequest(by: id)
        let selectedRangers = try await rangerRepository.fetchRangersByIds(rangerIds)
        let rangerNames = selectedRangers.map { $0.name }
        
        emergencyRequest.assignedRangers = rangerNames
        emergencyRequest.emergencyStatus = .ongoing
        
        try await rangerRepository.updateRangerAvailability(rangers: selectedRangers, available: false)
        try await emergencyRequestRepository.updateEmergencyRequest(request: emergencyRequest)
        
    }
    
}

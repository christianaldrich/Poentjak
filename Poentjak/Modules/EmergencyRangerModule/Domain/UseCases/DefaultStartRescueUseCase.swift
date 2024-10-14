//
//  StartRescueUseCase.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 02/10/24.
//

import Foundation

protocol StartRescueUseCaseProtocol {
    func fetchEmergencyRequest(emergencyRequest id: String, completion: @escaping (Result<(EmergencyRequest, [Ranger]), Error>) -> Void)
    func assignRangersToEmergency(emergencyRequest id: String, rangerIds: [String]) async throws
}

class DefaultStartRescueUseCase: StartRescueUseCaseProtocol {
    private let emergencyRequestRepository: AdminEmergencyRequestRepositoryProtocol
    private let rangerRepository: DefaultRangerRepository
    
    init(emergencyRequestRepository: AdminEmergencyRequestRepositoryProtocol, rangerRepository: DefaultRangerRepository) {
        self.emergencyRequestRepository = emergencyRequestRepository
        self.rangerRepository = rangerRepository
    }
    
    func fetchEmergencyRequest(emergencyRequest id: String, completion: @escaping (Result<(EmergencyRequest, [Ranger]), Error>) -> Void) {
        // Set up a listener for the emergency request
        emergencyRequestRepository.addListenerToEmergencyRequest(by: id) { result in
            switch result {
            case .success(let emergencyRequest):
                guard let emergencyRequest = emergencyRequest else {
                    completion(.failure(NSError(domain: "EmergencyRequest", code: 404, userInfo: [NSLocalizedDescriptionKey: "Emergency request not found"])))
                    return
                }
                Task {
                    do {
                        let availableRangers = try await self.rangerRepository.fetchRangersByTrack(trackId: emergencyRequest.user.trackId)
                        completion(.success((emergencyRequest, availableRangers)))
                    } catch {
                        completion(.failure(error))
                    }
                }

            case .failure(let error):
                completion(.failure(error))
            }
        }
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

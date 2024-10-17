//
//  FetchUsersUseCase.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 25/09/24.
//

import Foundation

protocol ActiveEmergencyUseCaseProtocol{
    func fetchActiveEmergencyByTrack(completion: @escaping ([EmergencyRequestModel]) -> Void)
    
}

struct ActiveEmergencyUseCase : ActiveEmergencyUseCaseProtocol{
    private let activeEmergencyRepository: ActiveEmergencyRepositoryProtocol
    private let userRepository: UserRepositoryProtocol
    
    init(activeEmergencyRepository: ActiveEmergencyRepositoryProtocol, userRepository: UserRepositoryProtocol) {
        self.activeEmergencyRepository = activeEmergencyRepository
        self.userRepository = userRepository
    }
    
    
    
    func fetchActiveEmergencyByTrack(completion: @escaping ([EmergencyRequestModel]) -> Void) {
        Task {
            let rangerTrackId = try await userRepository.fetchCurrentUserEmergency().trackId
            activeEmergencyRepository.fetchEmergencyRequestByTrack(trackId: rangerTrackId){ requests in
                print("\n\nREQUESTS: \(requests)")
                completion(requests)
                
            }
            
        }
    }
}

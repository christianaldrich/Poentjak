//
//  ActiveHikersUseCase.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 07/10/24.
//

import Foundation

protocol ActiveHikersUseCaseProtocol{
    func fetchActiveHikers(completion: @escaping([EmergencyRequestModel]) -> Void)
}

class ActiveHikersUseCase: ActiveHikersUseCaseProtocol{
    
    private let activeHikersRepository: ActiveHikersRepositoryProtocol
    private let userRepository: UserRepositoryProtocol

    
    init(activeHikersRepository: ActiveHikersRepositoryProtocol, userRepository: UserRepositoryProtocol) {
        self.activeHikersRepository = activeHikersRepository
        self.userRepository = userRepository
    }
    
    func fetchActiveHikers(completion: @escaping([EmergencyRequestModel]) -> Void){
        
        Task {
            let rangerTrackId = try await userRepository.fetchCurrentUserEmergency().trackId
//            print("\n\n\n\nTrackID: \(rangerTrackId)")
            
            activeHikersRepository.fetchActiveHikers(trackId: rangerTrackId){ requests in
//                print("\n\nREQUESTS: \(requests)")
                completion(requests)
                
            }
            
        }
    }
    
}

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
    
    init(activeHikersRepository: ActiveHikersRepositoryProtocol) {
        self.activeHikersRepository = activeHikersRepository
    }
    
    func fetchActiveHikers(completion: @escaping([EmergencyRequestModel]) -> Void){
        
        activeHikersRepository.fetchActiveHikers{ requests in
            completion(requests)
            
        }
    }
    
}

//
//  HikerProfileUseCase.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 10/11/24.
//

import Foundation

protocol HikerProfileUseCaseProtocol{
    func fetchHikerProfile(completion: @escaping (User) -> Void)
}


class HikerProfileUseCase: HikerProfileUseCaseProtocol{
    
    private let userRepository: UserRepositoryProtocol
    
    init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }

    func fetchHikerProfile(completion: @escaping (User) -> Void) {
        Task {
            do {
                // Fetch the current user ID
                let hiker = try await userRepository.fetchCurrentUserEmergency()
                
                print("\(hiker)")
                
                completion(hiker)
                
            } catch {
//                completion(.failure(error))
            }
        }
    }
    
}

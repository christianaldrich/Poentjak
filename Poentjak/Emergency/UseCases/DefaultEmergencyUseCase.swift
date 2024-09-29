//
//  DefaultEmergencyUseCase.swift
//  Poentjak
//
//  Created by Felicia Himawan on 27/09/24.
//

import Foundation
import FirebaseFirestore

class DefaultEmergencyUseCase: EmergencyUseCaseProtocol{
    
    
    private let userRepository: UserRepositoryProtocol
    private let emergencyRepository: EmergencyRepositoryProtocol
    
    init(userRepository: UserRepositoryProtocol, emergencyRepository: EmergencyRepositoryProtocol) {
        self.userRepository = userRepository
        self.emergencyRepository = emergencyRepository
    }
    
    func createEmergency(type: String) async throws {
        let userAuth = try await userRepository.fetchCurrentUser()
        
    
        let newEmergency = EmergencyModel(
            type : type,
            status: "sent to ranger"
        )
        
        try await emergencyRepository.createEmergency(userId: userAuth.id ,with: newEmergency)
    }
    
    
    func deleteEmergency() async throws {
        let userAuth = try await userRepository.fetchCurrentUser()
        
        try await emergencyRepository.deleteEmergency(userId: userAuth.id)

    }
    
}

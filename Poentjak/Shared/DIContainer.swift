//
//  DIContainer.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 26/09/24.
//

import Foundation

class DIContainer {
    // AuthViewModel
    @MainActor
    func makeAuthViewModel() -> AuthViewModel {
        let authRepository = DefaultAuthRepository()
        let userRepository = DefaultUserRepository()
        let useCase = DefaultAuthUseCase(
            authRepository: authRepository,
            userRepository: userRepository
        )
        return AuthViewModel(useCase: useCase)
    }
    
    @MainActor
    func makeAdminEmergencyViewModel() -> AdminEmergencyViewModel {
        let emergencyRequestRepository = DefaultAdminEmergencyRequestRepository()
        let rangerRepository = DefaultRangerRepository()
        let startRescueUseCase = DefaultStartRescueUseCase(
            emergencyRequestRepository: emergencyRequestRepository,
            rangerRepository: rangerRepository
        )
        let RangerUseCase = RangerUseCase(repository: rangerRepository)
        
        return AdminEmergencyViewModel(
            startRescueUseCase: startRescueUseCase,
            rangerUseCase: RangerUseCase
        )
    }

    
}

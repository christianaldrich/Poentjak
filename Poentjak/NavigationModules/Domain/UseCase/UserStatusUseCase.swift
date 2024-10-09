//
//  UserStatusUseCase.swift
//  Poentjak
//
//  Created by Shan Havilah on 08/10/24.
//

import Foundation

class UserStatusUseCase: UserStatusUseCaseProtocol {
    private let userRepository: UserRepositoryProtocol
    private let userStatusRepository: UserStatusRepositoryProtocol
    
    init(userRepository: UserRepositoryProtocol, userStatusRepository: UserStatusRepositoryProtocol) {
        self.userRepository = userRepository
        self.userStatusRepository = userStatusRepository
    }
    
    func updateStats(batteryLevel: Int, lastSeen: Date, lastLocation: Location) async throws {
        let user = try await userRepository.fetchCurrentUserEmergency()
        
        do {
            try await userStatusRepository.updateStats(userId: user.id, batteryLevel: batteryLevel, lastSeen: lastSeen, lastLocation: lastLocation)
        } catch {
            print("Failed to update Stats: \(error.localizedDescription)")
            throw error
        }
    }
    
}

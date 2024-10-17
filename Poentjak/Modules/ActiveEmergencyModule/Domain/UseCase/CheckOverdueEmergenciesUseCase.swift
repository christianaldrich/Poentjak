//
//  CheckOverdueEmergenciesUseCase.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 13/10/24.
//

import Foundation

protocol CheckOverdueEmergenciesUseCaseProtocol {
    func execute() async throws
}

class CheckOverdueEmergenciesUseCase: CheckOverdueEmergenciesUseCaseProtocol{
    
    private let emergencyRepository: ActiveEmergencyRepository
    
    init(emergencyRepository: ActiveEmergencyRepository) {
        self.emergencyRepository = emergencyRepository
    }
    
    func execute() {
        let now = Date()
        emergencyRepository.fetchEmergencyRequest { emergencies in
            for emergency in emergencies {
                if emergency.dueDate < now && emergency.emergencyStatus != "ongoing" && emergency.emergencyStatus != "safe" && emergency.emergencyType != "overdue"  {
                    Task {
                        do {
                            try await self.emergencyRepository.updateEmergencyRequestToOverdue(id: emergency.id)
                            print("Updated emergency \(emergency.id) to overdue")
                        } catch {
                            print("Failed to update emergency \(emergency.id): \(error)")
                        }
                    }
                }
            }
        }
    }
    
    
}


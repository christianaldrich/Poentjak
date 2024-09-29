//
//  EmergencyProsesViewModel.swift
//  Poentjak
//
//  Created by Felicia Himawan on 29/09/24.
//

import Foundation


class EmergencyProsesViewModel: ObservableObject{
    let useCase = DefaultEmergencyUseCase(userRepository: DefaultUserRepository(), emergencyRepository: DefaultEmergencyRepository())
    
    func deleteEmergency() async {
            do {
                try await useCase.deleteEmergency()
                print("Emergency deleted successfully")
            } catch {
                print("Failed to delete emergency: \(error.localizedDescription)")
            }
        }
  
}

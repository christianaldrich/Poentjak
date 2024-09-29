//
//  SheetViewModel.swift
//  Poentjak
//
//  Created by Felicia Himawan on 27/09/24.
//

import Foundation

class SheetViewModel: ObservableObject{
    let useCase = DefaultEmergencyUseCase(userRepository: DefaultUserRepository(), emergencyRepository: DefaultEmergencyRepository())
    
    func createEmergency(type: String) async{
        do {
                try await useCase.createEmergency(type: type)
                print("Emergency created successfully")
            } catch {
                // Handle the error here
                print("Failed to create emergency: \(error.localizedDescription)")
            }
    }
}

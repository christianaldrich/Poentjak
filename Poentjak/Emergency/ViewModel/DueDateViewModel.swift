//
//  DueDateViewModel.swift
//  Poentjak
//
//  Created by Felicia Himawan on 02/10/24.
//

import Foundation

class DueDateViewModel: ObservableObject{
    let emergencyUseCase = DefaultEmergencyUseCase(userRepository: DefaultUserRepository(), emergencyRepository: DefaultEmergencyRepository())
    
    @Published var dueDate: Date = Date()
    @Published var emergencyCreationSuccess: Bool = false
    
    func createEmergencyHiking() async {
        do {
            try await emergencyUseCase.createEmergency(dueDate: dueDate)
            print("Emergency hiking session created successfully")
            DispatchQueue.main.async { [weak self] in
                            self?.emergencyCreationSuccess = true // Set success on the main thread
                        }
        } catch {
            // Handle the error here
            print("Failed to create emergency hiking session: \(error.localizedDescription)")
            DispatchQueue.main.async { [weak self] in
                            self?.emergencyCreationSuccess = false // Set failure on the main thread
                        }
        }
    }
    
    func dueDateFormatted(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: dueDate)
    }
    
    func dueTimeFormatted() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: dueDate)
    }
    
}

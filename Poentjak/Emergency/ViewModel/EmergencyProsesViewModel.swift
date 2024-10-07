//
//  EmergencyProsesViewModel.swift
//  Poentjak
//
//  Created by Felicia Himawan on 29/09/24.
//

import Foundation

class EmergencyProsesViewModel: ObservableObject{
    let useCase = DefaultEmergencyUseCase(userRepository: DefaultUserRepository(), emergencyRepository: DefaultEmergencyRepository())
    
    @Published var status: String = "Loading..."
    
//    func fetchEmergency() {
//            useCase.fetchEmergency { result in
//                DispatchQueue.main.async {
//                    switch result {
//                    case .success(let emergency):
//                        self.status = emergency?.status ?? "No Status"
//                    case .failure(let error):
//                        print("Failed to fetch emergency: \(error.localizedDescription)")
//                        self.status = "Error fetching emergency"
//                    }
//                }
//            }
//        }
//    
//    func deleteEmergency() async {
//        do {
//            try await useCase.deleteEmergency()
//            print("Emergency deleted successfully")
//        } catch {
//            print("Failed to delete emergency: \(error.localizedDescription)")
//        }
//    }
//    
    
    
}

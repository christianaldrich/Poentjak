//
//  DueDateViewModel.swift
//  Poentjak
//
//  Created by Felicia Himawan on 02/10/24.
//

import Foundation

class DueDateViewModel: ObservableObject{
    let useCase = DefaultDueDateUseCase(userRepository: DefaultUserRepository(), dueDateRepository: DefaultDueDateRepository())
    let emergencyUseCase = DefaultEmergencyUseCase(userRepository: DefaultUserRepository(), emergencyRepository: DefaultEmergencyRepository())
    
    @Published var dueDate: Date = Date()
    
    
    //    func createEmergency(type: String) async{
    //        do {
    //                try await useCase.createEmergency(type: type)
    //                print("Emergency created successfully")
    //            } catch {
    //                // Handle the error here
    //                print("Failed to create emergency: \(error.localizedDescription)")
    //            }
    //    }
    
    func createEmergencyHiking() async {
        do {
            try await emergencyUseCase.createEmergency(dueDate: dueDate)
            print("Emergency hiking session created successfully")
        } catch {
            // Handle the error here
            print("Failed to create emergency hiking session: \(error.localizedDescription)")
        }
    }
    
    
//        func updateDueDate() async {
//            do {
//                try await useCase.updateDueDate(dueDate: dueDate)
//                print("due date updated successfully \(dueDate)")
//            } catch {
//                print("Failed to delete emergency: \(error.localizedDescription)")
//            }
//        }
    
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

//class EmergencyProsesViewModel: ObservableObject{
//    let useCase = DefaultEmergencyUseCase(userRepository: DefaultUserRepository(), emergencyRepository: DefaultEmergencyRepository())
//
//    @Published var status: String = "Loading..."
//
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
//
//
//}

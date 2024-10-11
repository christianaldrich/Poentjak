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
    @Published var userName: String = "name..."
    @Published var dueDate: Date = Date()
    @Published var sessionId: String = "no session id"
    
    
    @Published var emergencySessionActive: Bool = false
    @Published var isEmergencyLoading: Bool = false
    
    private var timer: Timer?
    
    
    func fetchEmergency() {
        self.isEmergencyLoading = true
        
        useCase.fetchEmergency { result in
            DispatchQueue.main.async {
                self.isEmergencyLoading = false
                
                switch result {
                case .success(let emergency):
                    self.status = emergency?.emergencyStatus.rawValue ?? "No Status"
                    self.userName = emergency?.user.name ?? "no found"
                    self.dueDate = emergency?.dueDate ?? Date()
                    self.sessionId = emergency?.id ?? "no session id"
                    self.emergencySessionActive = emergency != nil && emergency?.sessionDone == false  // Check if session is active
                    print ("this is in view model: \(self.emergencySessionActive)")// Check if session is active
                    //                    self.emergencySessionActive = emergency != nil && emergency?.sessionDone == false  // Check if session is active
                    
                case .failure(let error):
                    print("Failed to fetch emergency: \(error.localizedDescription)")
                    self.status = "Error fetching emergency"
                    self.emergencySessionActive = false  // Set to false if there's an error
                }
            }
        }
    }
    
    func updateSessionDone() async {
        do{
            try await useCase.updateSessionDone(sessionDone: true)
            stopTimer()
        } catch {
            print("Failed to delete emergency: \(error.localizedDescription)")
            
        }
    }
    
    //    func updateDueDate() async {
    //            do {
    //                try await useCase.updateDueDate(dueDate: dueDate)
    //                print("due date updated successfully \(dueDate)")
    //            } catch {
    //                print("Failed to delete emergency: \(error.localizedDescription)")
    //            }
    //        }
    
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
    
    func startTimer() {
        timer?.invalidate() // Invalidate any existing timer
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            Task {
                do {
                    try await self.useCase.checkAndUpdateOverdue(dueDate: self.dueDate, id: self.sessionId)
                    
                } catch {
                    print("Error checking overdue: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    deinit {
        stopTimer()
    }
    
    
    
}

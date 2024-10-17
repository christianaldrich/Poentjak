//
//  EmergencyProsesViewModel.swift
//  Poentjak
//
//  Created by Felicia Himawan on 29/09/24.
//

import Foundation

class EmergencyProsesViewModel: ObservableObject {
    let useCase = DefaultEmergencyUseCase(userRepository: DefaultUserRepository(), emergencyRepository: DefaultEmergencyRepository())
    
    @Published var status: String = "Loading..."
    @Published var userName: String = "name..."
    @Published var dueDate: Date = Date()
    @Published var sessionId: String = "no session id"
    @Published var emergencyType: EmergencyType = .hipo
    @Published var trackId: String = "gedeDefault"
    
    
    @Published var emergencySessionActive: Bool = false
    @Published var isEmergencyLoading: Bool = false
    
    private var timer: Timer?
    
    @Published var showSOSButtonView: Bool = false
    @Published var sendSOSToFirebase: Bool = false
    @Published var deleteAnimation: Bool = false
    
    @Published var isSignalSent: Bool = false
    
    @Published var countDownTime = 5
    var countDownTimer: Timer?
    
    //Temp
//    @Published var backToProses: Bool = false
    
    
    
    func createEmergencyHiking(trackId: String) async {
        do {
            try await useCase.createEmergency(dueDate: dueDate, trackId: trackId)
            startTimer()
            print("Emergency hiking session created successfully")
//            emergencySessionActive = true
            
            DispatchQueue.main.async { [weak self] in
                self?.emergencySessionActive = true // Set success on the main thread
                print("masuk viewmodel \(self?.emergencySessionActive ?? false)")
                        }
        } catch {
            // Handle the error here
            print("Failed to create emergency hiking session: \(error.localizedDescription)")
//            emergencySessionActive = false

            DispatchQueue.main.async { [weak self] in
                self?.emergencySessionActive = false // Set failure on the main thread
                        }
        }
    }
    
//    func createEmergencyHiking() {
//        self.emergencySessionActive = true
//    }
    
    func fetchEmergency() {
        useCase.fetchEmergency { result in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let emergency):
                    self.status = emergency?.emergencyStatus.rawValue ?? "No Status"
                    self.userName = emergency?.user.name ?? "no found"
                    self.dueDate = emergency?.dueDate ?? Date()
                    self.sessionId = emergency?.id ?? "no session id"
                    self.emergencySessionActive = emergency != nil && emergency?.sessionDone == false  // Check if session is active
                    self.trackId = emergency?.user.trackId ?? "no track id" // Check if session is active
                    print ("this is in view model: \(self.emergencySessionActive)")// Check if session is active
                    //                    self.emergencySessionActive = emergency != nil && emergency?.sessionDone == false  // Check if session is active
                    print("Fetched emergency session: active = \(self.emergencySessionActive)")
                    print("this is fetch text after sos: \(self.sendSOSToFirebase)")

                    
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
            self.emergencySessionActive = false
            print("sukses update session done")
        } catch {
            print("Failed to delete emergency: \(error.localizedDescription)")
            print("Failed to session done: \(error.localizedDescription)")
            
        }
    }
    
    func updateDueDate() async {
        do{
            try await useCase.updateDueDate(sessionId: sessionId, dueDate: dueDate)
        } catch {
            print("Failed to update due date in vm: \(error.localizedDescription)")
            
        }
    }
    
    func updateStatusType() async {
        
        do{
//            print("\n\n\n\nSESSION ID: \(sessionId)")
//            print("\n\n\n\nEMERGENCY TYPE: \(emergencyType)")
            try await useCase.updateStatusTypeEmergency(sessionId: sessionId, emergencyType: emergencyType.rawValue)
            
//            DispatchQueue.main.async{
//                self.backToProses = true
//                self.sendSOSToFirebase = true
////                navigationManager.popToRoot()
//            }
        } catch {
            print("Failed to update due date in vm: \(error.localizedDescription)")
            
        }
    }
    
    
    // Start the countdown
    func startCountDown(navigationManager: NavigationManager) {
        
//        print("\n\n\nSessionID: \(sessionId), emergencyType: \(emergencyType)")
        
        
        countDownTime = 5
        
        countDownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            
            if self.countDownTime > 0 {
                self.countDownTime -= 1
            } else {
                self.countDownFinished(navigationManager: navigationManager)
                timer.invalidate()
            }
        }
    }
    
    // The function to be called after 5 seconds
    func countDownFinished(navigationManager: NavigationManager) {
        print("Countdown Finished!")
        
        DispatchQueue.main.async {
            Task {
                self.isSignalSent = true
                await self.updateStatusType()
                self.sendSOSToFirebase = true
                self.showSOSButtonView = false
                self.deleteAnimation = true
                navigationManager.popToRoot()
            }
        }
        
    }
    
    func cancelCountDown() {
        countDownTimer?.invalidate() // Stop the timer
        countDownTimer = nil // Clear the timer reference
        countDownTime = 5 // Reset the countdown time
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

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
    
    
    func createEmergencyHiking(trackId: String) async {
        do {
            try await useCase.createEmergency(dueDate: dueDate, trackId: trackId)
            startTimer()
            print("Emergency hiking session created successfully")
            
            DispatchQueue.main.async { [weak self] in
                self?.emergencySessionActive = true // Set success on the main thread
                print("masuk viewmodel \(self?.emergencySessionActive ?? false)")
                        }
        } catch {
            
            print("Failed to create emergency hiking session: \(error.localizedDescription)")


            DispatchQueue.main.async { [weak self] in
                self?.emergencySessionActive = false // Set failure on the main thread
                        }
        }
    }
    
    
    func fetchEmergency() {
        useCase.fetchEmergency { result in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let emergency):
                    self.status = emergency?.emergencyStatus.rawValue ?? "No Status"
                    self.userName = emergency?.user.name ?? "no found"
                    self.dueDate = emergency?.dueDate ?? Date()
                    self.sessionId = emergency?.id ?? "no session id"
                    self.emergencySessionActive = emergency != nil && emergency?.sessionDone == false
                    self.trackId = emergency?.user.trackId ?? "no track id"
                    print ("this is in view model: \(self.emergencySessionActive)")
                    print("Fetched emergency session: active = \(self.emergencySessionActive)")
                    print("this is fetch text after sos: \(self.sendSOSToFirebase)")

                    
                case .failure(let error):
                    print("Failed to fetch emergency: \(error.localizedDescription)")
                    self.status = "Error fetching emergency"
                    self.emergencySessionActive = false
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
            try await useCase.updateStatusTypeEmergency(sessionId: sessionId, emergencyType: emergencyType.rawValue)
        } catch {
            print("Failed to update due date in vm: \(error.localizedDescription)")
            
        }
    }
    
    
    func startCountDown(navigationManager: NavigationManager) {
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
    
    func countDownFinished(navigationManager: NavigationManager) {
        print("Countdown Finished!")
        
        DispatchQueue.main.async {
            Task {
                self.isSignalSent = true
                await self.updateStatusType()
                self.sendSOSToFirebase = true
                SOSManager.shared.isSOS = true
                self.showSOSButtonView = false
                self.deleteAnimation = true
                navigationManager.popToRoot()
            }
        }
        
    }
    
    func cancelCountDown() {
        countDownTimer?.invalidate()
        countDownTimer = nil
        countDownTime = 5
    }
    
    func startTimer() {
        timer?.invalidate()
        
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

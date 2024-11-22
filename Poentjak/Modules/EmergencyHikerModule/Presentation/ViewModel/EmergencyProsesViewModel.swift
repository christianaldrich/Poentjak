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
    @Published var emergencyType: EmergencyType = .lost {
        didSet {
            switch emergencyType {
            case .hipo:
                self.alertGuideTextTabBar = "WARM"
            case .overdue:
                self.alertGuideTextTabBar = "WARM"
            case .lost:
                self.alertGuideTextTabBar = "STOP"
            case .injury:
                self.alertGuideTextTabBar = "CARE"
            }
        }
    }
    
    @Published var trackId: String = ""
    
    
    @Published var emergencySessionActive: Bool = false
    @Published var isEmergencyLoading: Bool = false
    
    private var timer: Timer?
    
    @Published var sendSOSToFirebase: Bool = false
    @Published var deleteAnimation: Bool = false
    
    @Published var isSignalSent: Bool = false
    
    @Published var countDownTime = 5
    var countDownTimer: Timer?
    
    @Published var emergencyStatus: EmergencyStatus = .completed
    
    @Published var emergencyScale: Double = 1
    
    @Published var assignedRangers: [String] = []
    
    
    // MARK: - start: ni logic buat alert guide
    @Published var alertGuideTextTabBar = "CARE" {
        didSet {
            getContentData()
        }
    }
    @Published var idSelected: Int = 1 {
        didSet {
            getContentData()
        }
    }
    
    @Published var contentData: AlertGuideContentDataModel = AlertGuideData.defaultData
    
    init() {
        getContentData()
    }
    
    func getContentData() {
        self.contentData = AlertGuideData.data[alertGuideTextTabBar]?[idSelected] ?? AlertGuideData.defaultData
    }

    
    // MARK: - start: ini logic buat create di due date view
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

    
    // MARK: - start: ini logic buat fetch active hiking dri firebase di emergency proses view
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
                    self.assignedRangers = emergency?.assignedRangers ?? []
                    self.emergencyType = emergency?.emergencyType ?? .lost
                    self.emergencyStatus = emergency?.emergencyStatus ?? .safe
                    print("DEBUG ASSIGNED RANGERS: \(self.assignedRangers)")
                    
//                    print ("this is in view model: \(self.emergencySessionActive)")
//                    print("Fetched emergency session: active = \(self.emergencySessionActive)")
//                    print("this is fetch text after sos: \(self.sendSOSToFirebase)")
                    
                    
                case .failure(let error):
                    print("Failed to fetch emergency: \(error.localizedDescription)")
                    self.status = "Error fetching emergency"
                    self.emergencySessionActive = false
                }
            }
        }
    }
    
    
    // MARK: - start: ini logic buat "i am back at basecamp" di emergency proses view
    func updateSessionDone() async {
        do{
            try await useCase.updateSessionDone(sessionDone: true, emergencyStatus: emergencyStatus.rawValue)
            stopTimer()
            
            DispatchQueue.main.async {
                self.emergencySessionActive = false
            }
            print("sukses update session done")
        } catch {
            print("Failed to delete emergency: \(error.localizedDescription)")
            print("Failed to session done: \(error.localizedDescription)")
            
        }
    }
    
    
    // MARK: - start: ini logic buat edit due date view
    func updateDueDate() async {
        do{
            let currentTime = Date()
            
            if dueDate <= currentTime {
                        try await useCase.updateDueDate(sessionId: sessionId, dueDate: dueDate)
                        print("Due date updated (overdue case).")
                    } else {
                        // If the due date is in the future, update the due date and emergency status
                        try await useCase.updateDueDate(sessionId: sessionId, dueDate: dueDate)
                        try await useCase.updateStatusSafe(sessionId: sessionId, emergencyStatus: "safe", emergencyType: "")
                        print("Due date and emergency status updated (not overdue).")
                    }
            
        } catch {
            print("Failed to update due date in vm: \(error.localizedDescription)")
            
        }
    }
    
    
    // MARK: - start: ini logic buat update emergency status ke firebase dari count down view
    func updateStatusType() async {
        
        do{
            try await useCase.updateStatusTypeEmergency(sessionId: sessionId, emergencyType: emergencyType.rawValue)
        } catch {
            print("Failed to update due date in vm: \(error.localizedDescription)")
            
        }
    }
    
    // MARK: - start: ini logic buat di countdown view
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
                SOSManager.shared.isSOS = true
                self.isSignalSent = true
                self.deleteAnimation = true
                navigationManager.popToRoot()
                await self.updateStatusType()
                self.sendSOSToFirebase = true
                
                
            }
        }
        
    }
    
    func cancelCountDown() {
        countDownTimer?.invalidate()
        countDownTimer = nil
        countDownTime = 5
    }
    
    
    // MARK: - start: ini logic buat overdue
    func startTimer() {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            Task {
                do {
                    try await self.useCase.checkAndUpdateOverdue(dueDate: self.dueDate, id: self.sessionId, emergencyStatus: self.status)
                    
                    
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

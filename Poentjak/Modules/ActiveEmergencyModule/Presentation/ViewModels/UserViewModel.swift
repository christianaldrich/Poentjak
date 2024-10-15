//
//  UserViewModel.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 25/09/24.
//

import Foundation
import SwiftUI


class UserViewModel: ObservableObject{
    
    @Published var user: [UserModel] = []
    @Published var hiker: [EmergencyRequestModel] = []
    
    
    private let repo = FirebaseDatabaseDS()
    private let activeEmRepo = ActiveEmergencyRepository()
    private var timer: Timer?
    
    func fetchEmergency(){
        repo.fetchUserInDanger() { [weak self] user in
            DispatchQueue.main.async {
                self?.user = user
            }
        }
    }
    
    func rescuing(id: String){
        activeEmRepo.confirmRescue(id: id){_ in
            print("rescuing")
        }
    }
    
    func fetchDangerHiker(){
        activeEmRepo.fetchEmergencyRequest{ [weak self] hiker in
            DispatchQueue.main.async{
                self?.hiker = hiker
//                print("\n\n\(hiker[0].dueDate.formatted(date: .complete, time: .shortened))")
                print("\n\n\n\(hiker)")
            }
        }
    }
    
//    func fetchHikerInfo(id: String){
//        activeEmRepo.fetchDangerHikersInfo(id: id){[weak self] user in
//            DispatchQueue.main.async{
//                self?.user = user
//                print("\n\n\nUSER: \(user)")
//                print("\n\n\nID: \(id)")
//            }
//        }
//    }
    
    func startTimer() {
            stopTimer()
            timer = Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) { [weak self] _ in
                guard let self = self else { return }
                
                Task {
                    for hiker in self.hiker {
                        if hiker.dueDate < Date() && hiker.emergencyStatus != "overdue" {
                            do {
                                try await self.activeEmRepo.updateEmergencyRequestToOverdue(id: hiker.id)
                                print("Updated hiker \(hiker.id) to overdue")
                            } catch {
                                print("Error updating hiker \(hiker.id) to overdue: \(error.localizedDescription)")
                            }
                        }
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

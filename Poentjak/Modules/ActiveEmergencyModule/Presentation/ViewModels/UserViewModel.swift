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
    @Published var completeRescue: [EmergencyRequestModel] = []
    
    private var oldHiker: [EmergencyRequestModel] = []
    private var newHiker: [EmergencyRequestModel] = []
    
    private let repo = FirebaseDatabaseDS()
    private let activeEmRepo = ActiveEmergencyRepository()
    private var timer: Timer?
    
    private let activeEmergencyUseCase: ActiveEmergencyUseCaseProtocol
    
    init( activeEmergencyUseCase: ActiveEmergencyUseCaseProtocol) {
        
        self.activeEmergencyUseCase = activeEmergencyUseCase
        //        fetchEmergencyByTrack(trackId: "")
    }
    
    func fetchEmergency(){
        repo.fetchUserInDanger() { [weak self] user in
            DispatchQueue.main.async {
                self?.user = user
            }
        }
    }
    func fetchActiveEmergencyByTrack(){
        activeEmergencyUseCase.fetchActiveEmergencyByTrack(){ [weak self] hikers in
            DispatchQueue.main.async {
                
                
                
                //                print("\n\nHIKERS IN VM: \(hikers)")
                self?.hiker = hikers
                //                self?.oldEmergency = hikers
            }
        }
    }
    
    func startNotify(_ hiker: [EmergencyRequestModel]){
        
        let newlyAdded = hiker.filter { newHiker in
            !oldHiker.contains(where: { $0.id == newHiker.id })
        }
        
//        let safeHiker = oldHiker.filter { safe in
//            !hiker.contains(where: { $0.id == safe.id })
//        }
        print("\n\nNewly Added\(newlyAdded)")
//        print("\n\nSafe Hiker\(safeHiker)")
        
        
//        print("\n\n\nHikers Notified: \(hiker)")
        for items in newlyAdded{
            NotificationManager.instance.scheduleNotification(
                title: "SOS Alert!",
                body: "\(items.user?.name) is \(items.emergencyType). Check their status now."
            )
        }
        
//        for items in safeHiker{
//            NotificationManager.instance.scheduleNotification(
//                title: "New Announcement!",
//                subtitle: "\(items.user?.name ?? "") have arrived safely!",
//                body: "Cheers!"
//            )
//        }
        
        self.oldHiker = hiker
    }
    
    //    func fetchActiveEmergencyByTrack() {
    //        activeEmergencyUseCase.fetchActiveEmergencyByTrack { [weak self] newData in
    //            DispatchQueue.main.async {
    //                guard let self = self else { return }
    //                let oldData = self.hiker
    //                print("\n\nOLD DATA: \(oldData)")
    //                print("\n\nNEW DATA: \(newData)")
    //                // Find added items
    //                let addedItems = newData.filter { newItem in
    //                    !oldData.contains(where: { $0.id == newItem.id })
    //                }
    //
    //                let temp =
    //
    //                print("\n\nADDED ITEMS: \(addedItems)")
    //
    //                // Notify if there's new data
    //                for addedItem in addedItems {
    ////                    if let hikerName = addedItem.user?.name {
    ////                    print("MASUUKK")
    //                    if addedItem.emergencyStatus == "danger"{
    ////                        print("SOMETHING")
    //                        print("\(addedItem.user?.name ?? "JOKO") in \(addedItem.emergencyStatus)")
    //                        NotificationManager.instance.scheduleNotification(
    //                            title: "New Emergency Request",
    //                            subtitle: "Emergency Type: \(addedItem.emergencyType)",
    //                            body: "\(addedItem.user?.name ?? "") needs help!"
    //                        )
    //                    }
    ////                    }
    //                }
    //
    //                // Update the current data
    //                self.hiker = newData
    //            }
    //        }
    //    }
    
    
    
    func fetchCompleteRescue(){
        activeEmergencyUseCase.fetchCompletedRescue(){ [weak self] rescues in
            DispatchQueue.main.async {
                self?.completeRescue = rescues
                
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
                //                print("\n\n\n\(hiker)")
            }
        }
    }
    
    func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            Task {
                for hiker in self.hiker {
                    //                    print("ajg \(hiker.dueDate) tes \(Date())")
                    if hiker.dueDate < Date() && hiker.emergencyStatus == "safe" {
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
    
    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: Date())
    }
    
    
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    deinit {
        stopTimer()
    }
    
}

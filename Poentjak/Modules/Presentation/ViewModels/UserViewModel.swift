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
    func fetchEmergency(){
        repo.fetchUserInDanger() { [weak self] user in
            DispatchQueue.main.async {
                self?.user = user
            }
        }
    }
    
    func rescuing(id: String){
        repo.confirmRescue(id: id){_ in
            print("rescuing")
        }
    }
    
    func fetchDangerHiker(){
        activeEmRepo.fetchEmergencyRequest{ [weak self] hiker in
            DispatchQueue.main.async{
                self?.hiker = hiker
//                print("\n\n\(hiker[0].dueDate.formatted(date: .complete, time: .shortened))")
            }
        }
    }
    
    func fetchHikerInfo(id: String){
        activeEmRepo.fetchDangerHikersInfo(id: id){[weak self] user in
            DispatchQueue.main.async{
                self?.user = user
                print("\n\n\nUSER: \(user)")
                print("\n\n\nID: \(id)")
            }
        }
    }
    
}

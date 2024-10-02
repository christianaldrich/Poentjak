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
    
    
    private let repo = FirebaseDatabaseDS()
    func fetchEmergency(){
        repo.fetchUserInDanger() { [weak self] user in
            //            print("\n\n\(user)")
            
            DispatchQueue.main.async {
                self?.user = user
                print("\n\nUSER ID: \(user[0].id)")
                print("\n\nUSER name: \(user[0].name)")
            }
        }
    }
    
    func rescuing(id: String){
        repo.confirmRescue(id: id){_ in
            print("rescuing")
        }
    }
    
    func rescueViewModel(id: String){
        repo.showRescueDetail(id: id){[weak self] user in
            
            DispatchQueue.main.async{
                self?.user = user
            }
            
        }
    }
    
}

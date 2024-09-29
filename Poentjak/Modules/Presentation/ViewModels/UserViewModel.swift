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
            }
        }
    }
    
    func rescuing(id: String){
        repo.confirmRescue(id: id){_ in 
            print("rescuing")
        }
    }
    
}

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
    
    private let repo = UserRepository()
    func fetchEmergency(){
        repo.fetchUserInDanger() { [weak self] user in
//            print("\n\n\(user)")
            
            DispatchQueue.main.async {
                self?.user = user
            }
        }
    }
    
}

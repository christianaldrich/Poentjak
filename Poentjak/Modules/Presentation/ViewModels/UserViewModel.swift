//
//  UserViewModel.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 25/09/24.
//

import Foundation
import SwiftUI

class UserViewModel: ObservableObject{
    private let useCase = DefaultFetchUsersUseCase(repository: DefaultUserRepository(dataSource: FirebaseDatabaseDS() as! DomainUserRepository))
    
    //    @Published var userReq = ""
//    @Published var response: UserModel
    
//    init(response: UserModel) {
//        self.response = response
//    }
    
    
    func getUsers() {
//        do {
//            let response = try await useCase.fetchUsers()
////            DispatchQueue.main.async {
////                self.response = response
////            }
//            print("Response View Model: \(response)")
//        } catch {
//            print("error")
//        }
        
        print(useCase.fetchUsers())
        
    }
    
    
}

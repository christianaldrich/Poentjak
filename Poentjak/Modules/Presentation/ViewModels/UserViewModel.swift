//
//  UserViewModel.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 25/09/24.
//

import Foundation
import SwiftUI

class UserViewModel: ObservableObject{
    private let useCase: FetchUsersUseCase
    
    //    @Published var userReq = ""
    @Published var response: String = "NAME"
    
    init(useCase: FetchUsersUseCase) {
        self.useCase = useCase
    }
    
    func getUsers() async {
        do {
            let response = try await useCase.fetchUsers(requestId: UserRequest(id: "user1"))
//            DispatchQueue.main.async {
//                self.response = response
//            }
            print("Response View Model: \(response)")
        } catch {
            print("error")
        }
    }
    
    
}

//
//  UserRepository.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 25/09/24.
//

import Foundation
import FirebaseFirestore


//protocol UserRepository{
//    func fetchUsers() async throws -> String
//}

struct DefaultUserRepository: DomainUserRepository{
    
    var dataSource: DomainUserRepository
    
    init(dataSource: DomainUserRepository) {
        self.dataSource = dataSource
    }
    
    func fetchUsers() -> UserModel {
        return dataSource.fetchUsers()
    }
    
}

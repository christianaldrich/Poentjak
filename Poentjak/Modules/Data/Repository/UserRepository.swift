//
//  UserRepository.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 25/09/24.
//

import Foundation
import FirebaseFirestore


protocol UserRepository{
    func fetchUsers(requestId : UserRequest) async throws -> String
}

class DefaultUserRepository: UserRepository{
    
    var dataSource: UserRepository
    
    init(dataSource: UserRepository) {
        self.dataSource = dataSource
    }
    
    func fetchUsers(requestId: UserRequest) async throws -> String {
        return try await dataSource.fetchUsers(requestId: requestId)
    }
    
}

//
//  FetchUsersUseCase.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 25/09/24.
//

protocol FetchUsersUseCase{
    func fetchUsers(requestId: UserRequest) async throws -> UserResponse
}

class DefaultFetchUsersUseCase : UserRepository{
//    func fetchUsers(requestId: UserRequest) async throws -> String {
//        <#code#>
//    }
    
    
    
    
    private let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func fetchUsers(requestId: UserRequest) async throws-> String{
        let response = try await repository.fetchUsers(requestId: requestId)
        print("Fetched")
//        return UserResponse(name: response)
        return response
    }
    
}

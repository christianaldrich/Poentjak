//
//  FetchUsersUseCase.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 25/09/24.
//

//protocol FetchUsersUseCase{
//    func fetchUsers() async throws -> UserModel
//}

struct DefaultFetchUsersUseCase : DomainUserRepository{
 
    
    private let repository: DomainUserRepository
    
    init(repository: DomainUserRepository) {
        self.repository = repository
    }
    
    func fetchUsers() -> UserModel {
        return repository.fetchUsers()
    }
    
//    func fetchUsers() async throws-> String{
////        let response = try await repository.fetchUsers()
////        print("Fetched")
//////        return UserResponse(name: response)
////        return response
//        
//        
//    }
    
}

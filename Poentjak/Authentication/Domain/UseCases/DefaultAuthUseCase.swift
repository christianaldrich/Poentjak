//
//  DefaultAuthUseCase.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 26/09/24.
//

import Foundation

class DefaultAuthUseCase: AuthUseCaseProtocol {
    private let repository: DefaultAuthRepository
    
    init(repository: DefaultAuthRepository) {
        self.repository = repository
    }
    
    func login(email: String, password: String) async throws -> UserAuth {
        return try await repository.signIn(with: email, password: password)
    }
    
    func register(request: AuthRequestDTO) async throws -> UserAuth {
        return try await repository.createUser(with: request)
    }
    
    func signOut() async throws {
        try await repository.signOut()
    }
    
    func fetchCurrentUser() async throws -> UserAuth {
        return try await repository.fetchCurrentUser()
    }
}

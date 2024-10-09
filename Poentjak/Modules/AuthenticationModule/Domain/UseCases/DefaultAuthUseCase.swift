//
//  DefaultAuthUseCase.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 26/09/24.
//

import Foundation

class DefaultAuthUseCase: AuthUseCaseProtocol {
    private let authRepository: AuthRepositoryProtocol
    private let userRepository: UserRepositoryProtocol
    
    init(authRepository: AuthRepositoryProtocol, userRepository: UserRepositoryProtocol) {
        self.authRepository = authRepository
        self.userRepository = userRepository
    }
    
    func login(email: String, password: String) async throws -> UserAuth {
        return try await authRepository.signIn(with: email, password: password)
    }
    
    func register(request: AuthRequestDTO) async throws -> UserAuth {
        return try await authRepository.createUser(with: request)
    }
    
    func signOut() async throws {
        try await authRepository.signOut()
    }
    
    func fetchCurrentUser() async throws -> UserAuth {
        return try await userRepository.fetchCurrentUser()
    }
}

//
//  DIContainer.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 26/09/24.
//

class DIContainer {
    @MainActor
    func makeAuthViewModel() -> AuthViewModel {
        let authRepository = DefaultAuthRepository()
        let userRepository = DefaultUserRepository()
        let useCase = DefaultAuthUseCase(
            authRepository: authRepository,
            userRepository: userRepository
        )
        return AuthViewModel(useCase: useCase)
    }
}

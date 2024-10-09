//
//  AuthViewModel.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 26/09/24.
//

import SwiftUI

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: UserAuth? = nil
    @Published var isAdmin: Bool = false
    @Published var isLoading: Bool = false
    @Published var loginError: String? = nil
    @Published var registrationError: String? = nil
    @Published var email: String = ""
    @Published var password: String = ""
    
    
    private let useCase: DefaultAuthUseCase

    init(useCase: DefaultAuthUseCase) {
        self.useCase = useCase
        Task {
            await fetchCurrentUser()
        }
    }
    
    func fetchCurrentUser() async {
        isLoading = true
        do {
            let user = try await useCase.fetchCurrentUser()
            userSession = user
            isAdmin = user.isAdmin
        } catch {
            print("Failed to fetch user: \(error.localizedDescription)")
        }
        isLoading = false
    }
    
    func login(email: String, password: String) async {
        isLoading = true
        do {
            let user = try await useCase.login(email: email, password: password)
            userSession = user
            isAdmin = user.isAdmin
            print("Login success")
        } catch {
            loginError = error.localizedDescription
            print("Failed to log in: \(error.localizedDescription)")
        }
        isLoading = false
    }
    
    func signOut() async {
        do {
            try await useCase.signOut()
            userSession = nil
            isAdmin = false
        } catch {
            print("Failed to sign out: \(error.localizedDescription)")
        }
    }
    
    func register() async {
        isLoading = true
        let request = AuthRequestDTO(email: email, password: password, isAdmin: false)
        do {
            let user = try await useCase.register(request: request)
            userSession = user
            isAdmin = user.isAdmin
        } catch {
            registrationError = error.localizedDescription
            print("Failed to register: \(error.localizedDescription)")
        }
        isLoading = false
    }
}

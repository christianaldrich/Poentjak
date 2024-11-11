//
//  AuthRepositoryProtocol.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 25/09/24.
//

import Foundation

protocol AuthRepositoryProtocol {
    func createUser(with request: AuthRequestDTO) async throws -> UserAuth
    func editUser(with request: AuthRequestDTO) async throws
    func signIn(with email: String, password: String) async throws -> UserAuth
    func signOut() async throws
    func deleteAccount() async throws
    func checkEmailExists(email: String) async -> Bool
}





//
//  AuthRepositoryProtocol.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 25/09/24.
//

import Foundation

protocol AuthRepositoryProtocol {
    func createUser(with request: AuthRequestDTO) async throws -> UserAuth
    func signIn(with email: String, password: String) async throws -> UserAuth
    func signOut() async throws
}





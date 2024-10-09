//
//  AuthUseCaseProtocol.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 26/09/24.
//

import Foundation
import Combine

protocol AuthUseCaseProtocol {
    func login(email: String, password: String) async throws -> UserAuth
    func register(request: AuthRequestDTO) async throws -> UserAuth
    func signOut() async throws
 
}

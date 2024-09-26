//
//  AuthRepositoryProtocol.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 25/09/24.
//

import Foundation

protocol AuthRepositoryProtocol {
    func fetchCurrentUser() async throws -> UserAuth
    func createUser(with request: AuthRequestDTO) async throws -> UserAuth
    func signIn(with email: String, password: String) async throws -> UserAuth
    func signOut() async throws
}








//import Combine
//
//protocol AuthRepositoryProtocol {
//    func fetchCurrentUser() -> AnyPublisher<UserAuth, Error>
//    func createUser(with request: AuthRequestDTO) -> AnyPublisher<UserAuth, Error>
//    func signIn(with email: String, password: String) -> AnyPublisher<UserAuth, Error>
//    func signOut() -> AnyPublisher<Void, Error>
//}

//
//  DefaultAuthRepository.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 25/09/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine

class DefaultAuthRepository: AuthRepositoryProtocol {
    private let firestore = Firestore.firestore()
    
    func fetchCurrentUser() async throws -> UserAuth {
        guard let uid = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "User not logged in", code: 401, userInfo: nil)
        }
        
        let docRef = firestore.collection("users").document(uid)
        do {
            let userAuth = try await docRef.getDocument(as: UserAuth.self)
            return userAuth
        } catch {
            throw NSError(domain: "User not found", code: 404, userInfo: nil)
        }
    }
    
    func createUser(with request: AuthRequestDTO) async throws -> UserAuth {
        let authResult = try await Auth.auth().createUser(withEmail: request.email, password: request.password)
        
        let userAuth = UserAuth(
            id: authResult.user.uid,
            email: request.email,
            fullname: request.fullname ?? "",
            username: request.username ?? "",
            isAdmin: request.isAdmin ?? false
        )
        
        let collectionRef = firestore.collection("users")
        
        do {
            let newDocReference: () = try collectionRef.document(userAuth.id).setData(from: userAuth)
            print("User stored with new document reference: \(newDocReference)")
            return userAuth
        } catch {
            print(error)
            throw error
        }
    }
    
    func signIn(with email: String, password: String) async throws -> UserAuth {
        _ = try await Auth.auth().signIn(withEmail: email, password: password)
        return try await fetchCurrentUser()
    }
    
    func signOut() async throws {
        do {
            try Auth.auth().signOut()
        } catch {
            throw error
        }
    }
    
    
    //    private var cancellables = Set<AnyCancellable>()
    //
    //    func fetchCurrentUser() -> AnyPublisher<UserAuth, Error> {
    //        Future { promise in
    //            guard let uid = Auth.auth().currentUser?.uid else {
    //                promise(.failure(NSError(domain: "User not logged in", code: 401)))
    //                return
    //            }
    //            self.firestore.collection("users").document(uid).getDocument { documentSnapshot, error in
    //                if let error = error {
    //                    promise(.failure(error))
    //                } else if let documentSnapshot = documentSnapshot, documentSnapshot.exists {
    //                    guard let userData = documentSnapshot.data() else {
    //                        promise(.failure(NSError(domain: "User data not found", code: 404)))
    //                        return
    //                    }
    //                    let userAuth = UserAuth(
    //                        id: uid,
    //                        email: userData["email"] as? String ?? "",
    //                        fullname: userData["fullname"] as? String ?? "",
    //                        username: userData["username"] as? String ?? "",
    //                        isAdmin: userData["isAdmin"] as? Bool ?? false
    //                    )
    //                    promise(.success(userAuth))
    //                } else {
    //                    promise(.failure(NSError(domain: "User not found", code: 404)))
    //                }
    //            }
    //        }
    //        .eraseToAnyPublisher()
    //    }
    //
    //    func createUser(with request: AuthRequestDTO) -> AnyPublisher<UserAuth, Error> {
    //        Future { promise in
    //            Auth.auth().createUser(withEmail: request.email, password: request.password) { result, error in
    //                if let error = error {
    //                    promise(.failure(error))
    //                } else if let result = result {
    //                    let userAuth = UserAuth(
    //                        id: result.user.uid,
    //                        email: request.email,
    //                        fullname: request.fullname ?? "",
    //                        username: request.username ?? "",
    //                        isAdmin: request.isAdmin ?? false
    //                    )
    //                    self.firestore.collection("users").document(userAuth.id).setData([
    //                        "email": request.email,
    //                        "fullname": request.fullname ?? "",
    //                        "username": request.username ?? "",
    //                        "isAdmin": request.isAdmin ?? false
    //                    ]) { error in
    //                        if let error = error {
    //                            promise(.failure(error))
    //                        } else {
    //                            promise(.success(userAuth))
    //                        }
    //                    }
    //                }
    //            }
    //        }
    //        .eraseToAnyPublisher()
    //    }
    //
    //    func signIn(with email: String, password: String) -> AnyPublisher<UserAuth, Error> {
    //        Future { promise in
    //            Auth.auth().signIn(withEmail: email, password: password) { result, error in
    //                if let error = error {
    //                    promise(.failure(error))
    //                } else if result != nil {
    //                    self.fetchCurrentUser()
    //                        .sink(receiveCompletion: { completion in
    //                            if case let .failure(error) = completion {
    //                                promise(.failure(error))
    //                            }
    //                        }, receiveValue: { userAuth in
    //                            promise(.success(userAuth))
    //                        })
    //                        .store(in: &self.cancellables)
    //                }
    //            }
    //        }
    //        .eraseToAnyPublisher()
    //    }
    //
    //    func signOut() -> AnyPublisher<Void, Error> {
    //        Future { promise in
    //            do {
    //                try Auth.auth().signOut()
    //                promise(.success(()))
    //            } catch {
    //                promise(.failure(error))
    //            }
    //        }
    //        .eraseToAnyPublisher()
    //    }
    //}
    
    
    
    //class DefaultAuthRepository: AuthRepositoryProtocol {
    //
    //    private let firestore = Firestore.firestore()
    //
    //    func fetchCurrentUser() async throws -> AuthResponseDTO {
    //        guard let uid = Auth.auth().currentUser?.uid else { throw NSError(domain: "User not logged in", code: 401) }
    //        let snapshot = try await firestore.collection("users").document(uid).getDocument()
    //        guard let userData = try snapshot.data(as: AuthResponseDTO?.self) else {
    //            throw NSError(domain: "User not found", code: 404)
    //        }
    //        return userData
    //    }
    //
    //    func createUser(with request: AuthRequestDTO) async throws -> AuthResponseDTO {
    //        let result = try await Auth.auth().createUser(withEmail: request.email, password: request.password)
    //        let user = AuthResponseDTO(
    //            id: result.user.uid,
    //            email: request.email,
    //            fullname: request.fullname ?? "",
    //            username: request.username ?? "",
    //            isAdmin: request.isAdmin ?? false,
    //            profileImageUrl: nil,
    //            bio: nil
    //        )
    //
    //        try await firestore.collection("users").document(user.id).setData(user.toDictionary())
    //        return user
    //    }
    //
    //
    //    func signIn(with email: String, password: String) async throws -> AuthResponseDTO {
    //        let result = try await Auth.auth().signIn(withEmail: email, password: password)
    //        return try await fetchCurrentUser()
    //    }
    //
    //    func signOut() throws {
    //        try Auth.auth().signOut()
    //    }
    //
    //
    //}
}

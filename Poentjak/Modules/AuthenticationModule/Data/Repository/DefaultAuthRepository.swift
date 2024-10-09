//
//  DefaultAuthRepository.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 25/09/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class DefaultAuthRepository: AuthRepositoryProtocol {
    private let firestore = Firestore.firestore()
    
    private let userRepository: UserRepositoryProtocol
    
    init(userRepository: UserRepositoryProtocol = DefaultUserRepository()) {
            self.userRepository = userRepository
        }
    
    func createUser(with request: AuthRequestDTO) async throws -> UserAuth {
        let authResult = try await Auth.auth().createUser(withEmail: request.email, password: request.password)
        
        let userAuth = UserAuth(
            id: authResult.user.uid,
            email: request.email,
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
        return try await userRepository.fetchCurrentUser()
    }
    
    func signOut() async throws {
        do {
            try Auth.auth().signOut()
        } catch {
            throw error
        }
    }
}

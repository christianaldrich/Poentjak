//
//  UserRepository.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 26/09/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

protocol UserRepositoryProtocol {
    func fetchCurrentUser() async throws -> UserAuth
}

class DefaultUserRepository: UserRepositoryProtocol {
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
}

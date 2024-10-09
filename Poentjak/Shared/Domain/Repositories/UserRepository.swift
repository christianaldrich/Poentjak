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
    func fetchCurrentUserEmergency() async throws -> User
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
    
    func fetchCurrentUserEmergency() async throws -> User {
        guard let uid = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "User not logged in", code: 401, userInfo: nil)
        }
        
        let docRef = firestore.collection("users").document(uid)
        print(docRef)
        do {
            let user = try await docRef.getDocument(as: User.self)
            
            return user
        } catch {
            
            print("Error fetching user: \(error)")

            throw NSError(domain: "User not found in fetch current user emergency", code: 404, userInfo: nil)
        }
    }
}

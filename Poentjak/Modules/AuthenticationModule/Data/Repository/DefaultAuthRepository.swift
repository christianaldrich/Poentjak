//
//  DefaultAuthRepository.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 25/09/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

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
            name: request.name,
            email: request.email,
            weight: request.weight,
            height: request.height,
            gender: request.gender,
            age: request.age,
            contactNumber: request.contactNumber,
            trackId: "none",
            contactName: request.contactName,
//            profileURL: request.profileURL,
            profileURL: "images/\(request.name).jpg",
            medicalRecord: request.medicalCondition,
            
            
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
    
    func checkEmailExists(email: String) async -> Bool {
        do {
            let emailNormalized = email.lowercased() 
            let querySnapshot = try await firestore.collection("users").whereField("email", isEqualTo: emailNormalized).getDocuments()
            
            // Debugging output to confirm the query result
            print("Query snapshot: \(querySnapshot)")
            return querySnapshot.documents.count > 0
        } catch {
            print("Failed to check email existence: \(error.localizedDescription)")
            return false
        }
    }

}

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
    
    func editUser(with request: AuthRequestDTO) async throws {
        
        guard let userId = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "AuthError", code: 1, userInfo: [NSLocalizedDescriptionKey: "User not authenticated"])
        }
        
        let collectionRef = firestore.collection("users")
        
        
        let newValues: [String: Any] = [
            "id": userId,
            "name": request.name,
            "weight": request.weight,
            "height": request.height,
            "gender": request.gender,
            "age": request.age,
            "contactNumber": request.contactNumber,
            "medicalRecord": request.medicalCondition ?? "None",
            "trackId": "none",
            "contactName": request.contactName,
            "profileURL": "images/\(request.name).jpg"
        ]
        
        do {
            // Use setData to update or create the document with new values
            try await collectionRef.document(userId).updateData(newValues)
            print("User stored with new document reference: \(userId)")
            
            // Return the updated user authentication object
//            return userAuth
        } catch {
            print("Error updating user:", error)
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
    
    func deleteAccount() async throws {
        guard let user = Auth.auth().currentUser else {
            throw NSError(domain: "No user signed in", code: 401, userInfo: nil)
        }

        let userEmail = user.email

        do {
            if let email = userEmail {
                let firestore = Firestore.firestore()
                let usersCollection = firestore.collection("users")
                
                let querySnapshot = try await usersCollection.whereField("email", isEqualTo: email).getDocuments()

                if let document = querySnapshot.documents.first {
                    try await document.reference.delete()
                }
            }

            try await user.delete()

        } catch {
            throw error
        }
    }


}

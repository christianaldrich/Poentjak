//
//  AuthViewModel.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 26/09/24.
//

import SwiftUI
import PhotosUI

import FirebaseStorage
import FirebaseFirestore

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: UserAuth? = nil
    @Published var isAdmin: Bool = false
    @Published var isLoading: Bool = false
    @Published var loginError: String? = nil
    @Published var registrationError: String? = nil
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var checkPassword: String = ""
    
    @Published var contactName: String = ""
    @Published var contactNumber: String = ""
    @Published var medicalCondition: String = ""
    @Published var age: Int = 1
    @Published var weight: Int = 1
    @Published var height: Int = 1
    
    
    @Published var name: String = ""
    @Published var gender: String = ""
    @Published var currentIndex: Int = -1
    @Published var capturedImage: UIImage?
    
    
    private let useCase: DefaultAuthUseCase

    init(useCase: DefaultAuthUseCase) {
        self.useCase = useCase
        Task {
            await fetchCurrentUser()
        }
    }
    
    func fetchCurrentUser() async {
        isLoading = true
        do {
            let user = try await useCase.fetchCurrentUser()
            userSession = user
            isAdmin = user.isAdmin
        } catch {
            print("Failed to fetch user: \(error.localizedDescription)")
        }
        isLoading = false
    }
    
    func login(email: String, password: String) async {
        isLoading = true
        do {
            let user = try await useCase.login(email: email, password: password)
            userSession = user
            isAdmin = user.isAdmin
            print("Login success")
        } catch {
            loginError = error.localizedDescription
            print("Failed to log in: \(error.localizedDescription)")
        }
        isLoading = false
    }
    
    func signOut() async {
        do {
            try await useCase.signOut()
            userSession = nil
            isAdmin = false
        } catch {
            print("Failed to sign out: \(error.localizedDescription)")
        }
    }
    
    func register() async {
        isLoading = true
        let request = AuthRequestDTO(email: email, password: password, isAdmin: false, contactName: contactName, contactNumber: contactNumber, medicalCondition: medicalCondition, age: age, weight: weight, height: height, name: name, gender: gender)
//        , profileURL: capturedImage
        do {
            let user = try await useCase.register(request: request)
            userSession = user
            isAdmin = user.isAdmin
        } catch {
            registrationError = error.localizedDescription
            print("Failed to register: \(error.localizedDescription)")
        }
        isLoading = false
    }
    
    func editUser() async {
        isLoading = true
        let request = AuthRequestDTO(email: email, password: password, isAdmin: false, contactName: contactName, contactNumber: contactNumber, medicalCondition: medicalCondition, age: age, weight: weight, height: height, name: name, gender: gender)
//        , profileURL: capturedImage
        do {
            let user: () = try await useCase.editUser(request: request)
//            userSession = user
//            isAdmin = user.isAdmin
        } catch {
            registrationError = error.localizedDescription
            print("Failed to update: \(error.localizedDescription)")
        }
        isLoading = false
    }
    
    func uploadPhoto(userName: String) async{
        guard capturedImage != nil else {
            return
        }
        
        let storageRef = Storage.storage().reference()
        
        let imageData = capturedImage!.jpegData(compressionQuality: 0.8)
        
        guard imageData != nil else {
            return
        }
        
        let path = "images/\(userName).jpg"
        
        let fileRef = storageRef.child(path)
        
        let uploadTask = fileRef.putData(imageData!, metadata: nil){ metadata, error in
            
//            if error == nil && metadata != nil{
//                //save reference
//                
//                let db = Firestore.firestore()
//                db.collection("users").document().setData(["profileURL": path])
//                
//                
//            }
            
        }
        
        func updateProfile(){
            
        }
        
        
    }
}

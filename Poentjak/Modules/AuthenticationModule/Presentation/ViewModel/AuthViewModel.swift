//
//  AuthViewModel.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 26/09/24.
//

import SwiftUI
import PhotosUI

import FirebaseStorage
import FirebaseAuth
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
    @Published var age: Int = 21
    @Published var weight: Int = 72
    @Published var height: Int = 170
    
    @Published var ageInteracted: Bool = false
    @Published var weightInteracted: Bool = false
    @Published var heightInteracted: Bool = false
    
    
    @Published var name: String = ""
    @Published var gender: String = ""
    @Published var currentIndex: Int = -1
    @Published var capturedImage: UIImage?
    @Published var retrievedImage: UIImage?
    
    //buat delete
    @Published var isLoadingDelete: Bool = false
    @Published var errorMessageDelete: String = ""
    
    @Published var appIsLoading: Bool = false
    
    //test
    @Published var isDone: Bool = false
    
    
    private var isEmailValidated = false
    
    private let useCase: DefaultAuthUseCase

    init(useCase: DefaultAuthUseCase) {
        self.useCase = useCase
        Task {
            await fetchCurrentUser()
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
            let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
            return emailPredicate.evaluate(with: email)
        }

    func validateEmail(email: String) async -> String? {
            if !isValidEmail(email) {
                return "Invalid email address"
            }
            
        let emailExists = await useCase.checkEmailExists(email: email)
        
        print(emailExists)
            
        if emailExists {
                return "Email has already been used"
            }
            
            isEmailValidated = true
            return nil
        }

        func validatePassword() -> String? {
            if password.count < 8 {
                return "Must be at least 8 characters"
            }
            if password != checkPassword {
                return "Passwords do not match"
            }
            return nil
        }
    
    func fetchCurrentUser() async {
        isLoading = true
        appIsLoading = true
        do {
            let user = try await useCase.fetchCurrentUser()
            userSession = user
            isAdmin = user.isAdmin
        } catch {
            print("Failed to fetch user: \(error.localizedDescription)")
        }
        isLoading = false
        appIsLoading = false
    }
    
    func login(email: String, password: String) async {
        isLoading = true
        do {
            let user = try await useCase.login(email: email, password: password)
            isAdmin = user.isAdmin
            userSession = user
            print("DEBUGGING \(isAdmin)")
            
            print("Login success")
        } catch let error as NSError {
            loginError = error.localizedDescription
            print("Failed to log in: \(error.localizedDescription)")

            switch error.code {
            case AuthErrorCode.wrongPassword.rawValue:
                loginError = "Incorrect email or password."
            case AuthErrorCode.invalidEmail.rawValue:
                loginError = "Incorrect email or password."
            case AuthErrorCode.networkError.rawValue:
                loginError = "Network error. Please check your internet connection."
            case AuthErrorCode.accountExistsWithDifferentCredential.rawValue:
                loginError = "An account already exists with different credentials."
            default:
                loginError = "Incorrect email or password."
            }
        }
        isLoading = false
    }
    
    func signOut() async {
        do {
            try await useCase.signOut()
            clearAll()
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
        
//        print("\n\n\\nMEDICAL CONDITION:\(request.medicalCondition)")
//        print("\n\n\\nTESTING:\(request.name)")
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
        
        print("masuk")
        print("\(String(describing: capturedImage))")
        guard capturedImage != nil else {
            return
        }
        
        let storageRef = Storage.storage().reference()
        
        let imageData = capturedImage!.jpegData(compressionQuality: 0.8)
        
        guard imageData != nil else {
            return
        }
        
        let path = "images/\(userName).jpg"
        
        print("\n\n\(userName)")
        print("\n\n\(path)")
        
        let fileRef = storageRef.child(path)
        
        let uploadTask = fileRef.putData(imageData!, metadata: nil){ metadata, error in
            
            if error == nil && metadata != nil{
                //save reference
                
                let db = Firestore.firestore()
                db.collection("users").document().setData(["profileURL": path])
                
                
            }
            
        }
        
    }
    
    func updatePhoto(oldPath: String, userName: String) async{
        
        let storageRef = Storage.storage().reference()
        
        if capturedImage == nil{
            retrievePhoto(userName: userName)
            
            guard retrievedImage != nil else {
                return
            }
            
            let imageData = retrievedImage?.jpegData(compressionQuality: 0.8)
            
            guard imageData != nil else {
                return
            }
            
            let oldPath = "images/\(oldPath).jpg"
            let path = "images/\(userName).jpg"
            
            
            let oldFileRef = storageRef.child(oldPath)
            let newFileRef = storageRef.child(path)
            
            
            
            let uploadTask = newFileRef.putData(imageData!, metadata: nil){ metadata, error in
                
                if error == nil && metadata != nil{
                    //save reference
                    
                    let db = Firestore.firestore()
                    db.collection("users").document().updateData(["profileURL": path])
                    
                    
                }
                
            }
            
            Task{
                try await oldFileRef.delete()
            }
            
        }else{
            guard capturedImage != nil else {
                return
            }
            
            let imageData = capturedImage?.jpegData(compressionQuality: 0.8)
            
            guard imageData != nil else {
                return
            }
            
            let oldPath = "images/\(oldPath).jpg"
            let path = "images/\(userName).jpg"
            
            
            let oldFileRef = storageRef.child(oldPath)
            let newFileRef = storageRef.child(path)
            
            
            
            let uploadTask = newFileRef.putData(imageData!, metadata: nil){ metadata, error in
                
                if error == nil && metadata != nil{
                    //save reference
                    
                    let db = Firestore.firestore()
                    db.collection("users").document().updateData(["profileURL": path])
                    
                    
                }
                
            }
            
            Task{
                try await oldFileRef.delete()
            }
        }
        
        
        
        
        
        
        
        
    }
    
    func retrievePhoto(userName: String){
        let db = Firestore.firestore()
        
        db.collection("users")
            .whereField("name", isEqualTo: userName)
            .getDocuments{ snapshot, error in
        
            if error == nil && snapshot != nil {
                
                
                for doc in snapshot!.documents{
                        let path = doc["profileURL"] as! String
//                    {
                        
                        let storageRef = Storage.storage().reference()
                        let fileRef = storageRef.child(path)
                        print("\nPATH: \(path)")
                        
                        fileRef.getData(maxSize: 5 * 1024 * 1024){ data, error in
                            if error == nil && data != nil{
                                
                                if let image = UIImage(data: data!){
                                    DispatchQueue.main.async{
                                        print("\nRETRIEVED IMAGE: \(String(describing: self.retrievedImage))")
                                        self.retrievedImage = image
                                    }
                                }
                            }
                        }
//                    }
                    
                }
                
                
            }
            
        }
    }
    
    func retrievePhotoRanger(userName: String, completion: @escaping (UIImage?) -> Void) {
        let db = Firestore.firestore()
        
        db.collection("users")
            .whereField("name", isEqualTo: userName)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching user: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
                
                guard let snapshot = snapshot, !snapshot.documents.isEmpty else {
                    print("No user found with the name \(userName).")
                    completion(nil)
                    return
                }
                
                // Assuming the first document is the correct user
                if let path = snapshot.documents.first?["profileURL"] as? String {
                    let storageRef = Storage.storage().reference()
                    let fileRef = storageRef.child(path)
                    
                    fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                        if let error = error {
                            print("Error fetching image data: \(error.localizedDescription)")
                            completion(nil)
                            return
                        }
                        
                        if let data = data, let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                completion(image)
                            }
                        } else {
                            print("Failed to create image from data.")
                            completion(nil)
                        }
                    }
                } else {
                    print("Profile URL is missing for user \(userName).")
                    completion(nil)
                }
            }
    }

    
    func deleteAccount() async {
        isLoadingDelete = true
        errorMessageDelete = ""
        
        do {
            try await useCase.deleteAccount()
        } catch {
            errorMessageDelete = "Failed to delete account: \(error.localizedDescription)"
        }
        
        clearAll()
        isLoading = false
    }
    
    func clearAll(){
        self.email = ""
        self.age = 21
        self.weight = 75
        self.height = 175
        self.password = ""
        self.checkPassword = ""
        self.capturedImage = nil
        self.contactName = ""
        self.contactNumber = ""
        self.name = ""
        self.retrievedImage = nil
        self.gender = ""
        self.medicalCondition = ""
    }
    
    
}

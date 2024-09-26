//
//  FirebaseDatabaseDS.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 25/09/24.
//

import Foundation
import FirebaseFirestore

//protocol FirebaseDatabaseProtocol{
//    func fetchUsers(prompt: String) async throws -> String
//}

class FirebaseDatabaseDS: ObservableObject, DomainUserRepository{
    
    
    
    
    
    let db = Firestore.firestore()
    
    @Published var users: UserModel?
    @Published var errorMessage: String?
    
    func fetchUsers() -> UserModel {
        
        db.collection("users").getDocuments { (snapshot, error) in
            
            if let error = error {
                print("Error fetching data: \(error)")
            } else {
                for document in snapshot!.documents {
                    let data = document.data()
                    
                    let name = data["name"] ?? "Unknown"
                    let age = data["age"] ?? 0
                    let isDanger = data["isDanger"] ?? false
                    let lastSeen =  data["lastSeen"] ?? GeoPoint(latitude: 0.0, longitude: 0.0)
                    
                    print("Name: \(name)\nAge: \(age)\nisDanger: \(isDanger)\nlastSeen: \(lastSeen)")
                    let user = UserModel(name: name as! String, age: age as! Int, isDanger: isDanger as! Bool)
                    return user
                }
            }
        }
        
        
        
    }
                
                //    @Published var users: [UserRequest] = [] // If you expect multiple users
                
                ////                var users: [UserModel] = []
                ////
                ////                for document in snapshot!.documents {
                ////                    do {
                ////                        if let user = try document.data(as: UserModel.self) {
                ////                            users.append(user)
                ////                        }
                ////                    } catch {
                ////                        completion(.failure(error)) // Return the decoding error
                ////                        return
                ////                    }
                ////                }
                ////                completion(.success(users)) // Return the users array when fetching is complete
                //
                //            }
                //        }
                //    }
                
                //    func fetchUsers() async throws -> UserModel{
                //
                //
                //        let docRef = db.collection("users").document("user1")
                //
                //        do {
                //            let documentSnapshot = try await docRef.getDocument()
                //            if let userData = try documentSnapshot.data(as: UserModel.self) {
                //                return userData
                //            } else {
                //                throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Document does not exist or could not be decoded"])
                //            }
                //        } catch {
                //            throw error
                //        }
                ////        do {
                ////            let document = try docRef.getDocument()
                ////            let userData = try document.data(as: UserModel.self)
                ////            return userData
                ////        } catch {
                ////            throw error
                ////        }
                //
                //        //        docRef.getDocument { document, error in
                //        //            if let error = error as NSError? {
                //        ////                completion(.failure(error))  Return error via completion handler
                //        //
                //        //                DispatchQueue.main.async {
                //        //                    self.errorMessage = "Error getting document: \(error.localizedDescription)"
                //        //                }
                //        //            }
                //        //            else {
                //        //                if let document = document {
                //        //                    do {
                //        //                        let userData = try document.data(as: UserModel.self)
                //        ////                        completion(.success(userData)) // Return user data via completion handler
                //        //
                //        //                        DispatchQueue.main.async {
                //        //                            self.users = userData
                //        //                        }
                //        //                    } catch {
                //        ////                        completion(.failure(error)) // Return decoding error
                //        //
                //        //                        DispatchQueue.main.async {
                //        //                            self.errorMessage = "Error decoding user: \(error.localizedDescription)"
                //        //                        }
                //        //                    }
                //        //                }
                //        //            }
                //        //        }
                //
                //    }
            
            //    func fetchBook(documentId: String) {
            //
            //    }
            
            
            
            
            
            

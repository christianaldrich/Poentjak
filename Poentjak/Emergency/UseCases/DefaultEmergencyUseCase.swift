//
//  DefaultEmergencyUseCase.swift
//  Poentjak
//
//  Created by Felicia Himawan on 27/09/24.
//

import Foundation
import FirebaseFirestore

class DefaultEmergencyUseCase: EmergencyUseCaseProtocol{
    
    
    private let userRepository: UserRepositoryProtocol
    private let emergencyRepository: EmergencyRepositoryProtocol
    
    init(userRepository: UserRepositoryProtocol, emergencyRepository: EmergencyRepositoryProtocol) {
        self.userRepository = userRepository
        self.emergencyRepository = emergencyRepository
    }
    
    func createEmergency(dueDate: Date) async throws {
        let user = try await userRepository.fetchCurrentUserEmergency()
        let newEmergencyRef = Firestore.firestore().collection("emergencyRequests").document()
        
        let newEmergency = EmergencyModel(
                    id: newEmergencyRef.documentID,
                    trackId: "gede1",
                    emergencyType: "",
                    emergencyStatus: "Safe",
                    dueDate: dueDate,
                    assignedRangers: ["ranger1", "ranger2"],
                    lastLocation: LocationModel(latitude: 0.0, longitude: 0.0),
                    batteryHealth: 60,
                    lastSeen: Date(),
                    sessionDone: false,
                    user: User(id: user.id, name: user.name, age: user.age, gender: user.gender, height: user.height, weight: user.weight, contactName: user.contactName, contactNumber: user.contactNumber, medicalRecord: user.medicalRecord, profileURL: user.profileURL, trackId: user.trackId))
        
                try await emergencyRepository.createEmergency(with: newEmergency)
        
    }
    
//    func createEmergency(type: String) async throws {
//        let userAuth = try await userRepository.fetchCurrentUser()
//        let newEmergencyRef = Firestore.firestore().collection("emergencyRequests").document()
//        
//        //        let newEmergency = EmergencyModel(
//        //            id: newEmergencyRef.documentID,
//        //            userId: userAuth.id,
//        //            trackId: nil,
//        //            emergencyType: type,
//        //            status: "Pending",
//        //            dueDate: nil,
//        //            assignedRanger: [],
//        //            lastLocation: nil
//        //        )
//        
//        //        let newEmergency = EmergencyModel(
//        //            id: newEmergencyRef.documentID,
//        //            userId: userAuth.id,
//        //            trackId: "ambil dri user",
//        //            emergencyType: type,
//        //            status: "Pending",
//        //            dueDate: Date(),
//        //            assignedRangers: ["ranger 1", "ranger 2", "ranger 3"],
//        //            lastLocation: LocationModel(latitude: 0.0, longitude: 0.0)
//        //
//        //        )
//        
//        let newEmergency = EmergencyModel(
//            id: newEmergencyRef.documentID,
//            trackId: "gede1",
//            emergencyType: "",
//            emergencyStatus: "Safe",
//            dueDate: Date(),
//            assignedRangers: ["ranger1", "ranger2"],
//            lastLocation: LocationModel(latitude: 0.0, longitude: 0.0),
//            batteryHealth: 60,
//            lastSeen: Date(),
//            sessionDone: false,
//            user: UserAuth(
//                id: userAuth.id,
//                email: userAuth.email,
//                fullname: userAuth.fullname,
//                username: userAuth.username,
//                isAdmin: userAuth.isAdmin))
//        
//        try await emergencyRepository.createEmergency(with: newEmergency)
//    }
    
//    func deleteEmergency() async throws {
//        let userAuth = try await userRepository.fetchCurrentUser()
//        
//        do {
//            try await emergencyRepository.deleteEmergency(userId: userAuth.id)
//        } catch {
//            // Handle the error (e.g., document not found)
//            print("Failed to delete emergency: \(error.localizedDescription)")
//            throw error // Re-throw if you want to handle it further up the call stack
//        }
//    }
//    
//    func fetchEmergency(completion: @escaping (Result<EmergencyModel?, Error>) -> Void) {
//        Task {
//            do {
//                let userId = try await userRepository.fetchCurrentUser().id
//                emergencyRepository.fetchEmergency(userId: userId) { result in
//                    completion(result)
//                }
//            } catch {
//                completion(.failure(error))
//            }
//        }
//    }
    
}

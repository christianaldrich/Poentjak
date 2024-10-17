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
    
    func createEmergency(dueDate: Date, trackId: String) async throws {
        let user = try await userRepository.fetchCurrentUserEmergency()
        //        let newEmergencyRef = Firestore.firestore().collection("emergencyRequests").document()
        let newEmergencyRef = Firestore.firestore().collection("emergencyRequests").document()
        
        
        let newEmergency = EmergencyRequest(id: newEmergencyRef.documentID, emergencyType: nil, emergencyStatus: .safe, assignedRangers: nil, batteryHealth: nil, lastLocation: nil, lastSeen: nil, dueDate: dueDate, sessionDone: false,
                                            user: User(id: user.id, name: user.name, age: user.age, gender: user.gender, height: user.height, weight: user.weight, contactName: user.contactName, contactNumber: user.contactNumber, medicalRecord: user.medicalRecord, profileURL: user.profileURL, trackId: trackId))
        
        print ("this is repo emergency!!! \(user.id)")
        
        try await emergencyRepository.createEmergency(with: newEmergency)
        print ("this is repo emergency!!! \(user.id)")
        
    }
    
    func updateSessionDone(sessionDone: Bool) async throws {
        let user = try await userRepository.fetchCurrentUserEmergency()
        
        
        do{
            try await emergencyRepository.updateSessionDone(userId: user.id, sessionDone: sessionDone)
        } catch {
            print("Failed to update session done: \(error.localizedDescription)")
            throw error
        }

    }
    
    func updateDueDate(sessionId: String, dueDate: Date) async throws {
        do{
            try await emergencyRepository.updateDueDate(sessionId: sessionId, dueDate: dueDate)
        } catch {
            print("Failed to update due date in use case: \(error.localizedDescription)")
            throw error
        }
    }
    
    func updateStatusTypeEmergency(sessionId: String, emergencyType: String) async throws {
        let emergencyStatus: EmergencyStatus = .danger
        do{
            try await emergencyRepository.updateStatusTypeEmergency(sessionId: sessionId, emergencyStatus: emergencyStatus.rawValue, emergencyType: emergencyType)
        } catch {
            print("Failed to update status & type in use case: \(error.localizedDescription)")
            throw error
        }
    }
    
//    func updateDueDate(dueDate: Date) async throws {
//        let userAuth = try await userRepository.fetchCurrentUser()
//        
//        do {
//            try await dueDateRepository.updateDueDate(userId: userAuth.id, dueDate: dueDate)
//        } catch {
//            // Handle the error (e.g., document not found)
//            print("Failed to update due date: \(error.localizedDescription)")
//            throw error // Re-throw if you want to handle it further up the call stack
//        }
//
//    }
    
    //    func createEmergency(dueDate: Date) async throws {
    //        let user = try await userRepository.fetchCurrentUserEmergency()
    //        let newEmergencyRef = Firestore.firestore().collection("emergencyRequests").document()
    //
    //        let newEmergency = EmergencyModel(
    //                    id: newEmergencyRef.documentID,
    //                    trackId: "gede1",
    //                    emergencyType: "",
    //                    emergencyStatus: "Safe",
    //                    dueDate: dueDate,
    //                    assignedRangers: ["ranger1", "ranger2"],
    //                    lastLocation: LocationModel(latitude: 0.0, longitude: 0.0),
    //                    batteryHealth: 60,
    //                    lastSeen: Date(),
    //                    sessionDone: false,
    //                    user: User(id: user.id, name: user.name, age: user.age, gender: user.gender, height: user.height, weight: user.weight, contactName: user.contactName, contactNumber: user.contactNumber, medicalRecord: user.medicalRecord, profileURL: user.profileURL, trackId: user.trackId))
    //
    //                try await emergencyRepository.createEmergency(with: newEmergency)
    //
    //    }
    
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
    
    
    
    func fetchEmergency(completion: @escaping (Result<EmergencyRequest?, any Error>) -> Void) {
        Task {
            do {
                // Fetch the current user ID
                let userId = try await userRepository.fetchCurrentUserEmergency().id
                
                // Fetch the emergency data from the repository
                emergencyRepository.fetchEmergency(userId: userId) { result in
                    completion(result.map { $0 }) // Map the result to EmergencyRequest
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
    //        func fetchEmergency(completion: @escaping (Result<EmergencyModel?, Error>) -> Void) {
    //            Task {
    //                do {
    //                    let userId = try await userRepository.fetchCurrentUser().id
    //                    emergencyRepository.fetchEmergency(userId: userId) { result in
    //                        completion(result)
    //                    }
    //                } catch {
    //                    completion(.failure(error))
    //                }
    //            }
    //        }
    
    func checkAndUpdateOverdue(dueDate: Date, id: String) async throws {
        let currentDate = Date()
        
        if currentDate > dueDate {
            try await emergencyRepository.updateEmergencyRequestToOverdue(id: id)
            print("overdue")
        }
        print("not overdue\(dueDate) = \(currentDate)")
    }
    
}

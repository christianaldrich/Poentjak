//
//  EmergencyRepositoryProtocol.swift
//  Poentjak
//
//  Created by Felicia Himawan on 27/09/24.
//

import Foundation

protocol EmergencyRepositoryProtocol {
    func createEmergency(with emergency: EmergencyRequest) async throws
//    func createEmergency(with emergency: EmergencyModel) async throws

//    func deleteEmergency(userId: String) async throws
    func fetchEmergency(userId: String, completion: @escaping (Result<EmergencyRequest?, Error>) -> Void)
    func updateSessionDone(userId: String, sessionDone: Bool) async throws
    
    func updateEmergencyRequestToOverdue(id: String) async throws 
    func updateDueDate(sessionId: String, dueDate: Date) async throws
    func updateStatusTypeEmergency(sessionId: String, emergencyStatus: String, emergencyType: String) async throws

}


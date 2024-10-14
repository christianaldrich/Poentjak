//
//  EmergencyUseCaseProtocol.swift
//  Poentjak
//
//  Created by Felicia Himawan on 27/09/24.
//

import Foundation

protocol EmergencyUseCaseProtocol {
    func createEmergency(dueDate: Date) async throws
//    func createEmergency(type: String) async throws
//    func deleteEmergency() async throws
//    func fetchEmergency(completion: @escaping (Result<EmergencyModel?, Error>) -> Void)
    func fetchEmergency(completion: @escaping (Result<EmergencyRequest?, Error>) -> Void)
    func updateSessionDone(sessionDone: Bool) async throws
    func updateDueDate(sessionId: String, dueDate: Date) async throws
    func updateStatusTypeEmergency(sessionId: String, emergencyType: String) async throws


}

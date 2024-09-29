//
//  EmergencyRepositoryProtocol.swift
//  Poentjak
//
//  Created by Felicia Himawan on 27/09/24.
//

import Foundation

protocol EmergencyRepositoryProtocol {
    func createEmergency(userId: String, with emergency: EmergencyModel) async throws
    func deleteEmergency(userId: String) async throws

}


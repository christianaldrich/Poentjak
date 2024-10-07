//
//  EmergencyRepositoryProtocol.swift
//  Poentjak
//
//  Created by Felicia Himawan on 27/09/24.
//

import Foundation

protocol EmergencyRepositoryProtocol {
    func createEmergency(with emergency: EmergencyModel) async throws
//    func deleteEmergency(userId: String) async throws
//    func fetchEmergency(userId: String, completion: @escaping (Result<EmergencyModel?, Error>) -> Void)

}


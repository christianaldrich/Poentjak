//
//  EmergencyUseCaseProtocol.swift
//  Poentjak
//
//  Created by Felicia Himawan on 27/09/24.
//

import Foundation

protocol EmergencyUseCaseProtocol {
    func createEmergency(type: String) async throws
    func deleteEmergency() async throws

}

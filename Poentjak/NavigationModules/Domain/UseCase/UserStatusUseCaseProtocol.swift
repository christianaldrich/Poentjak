//
//  UserStatusUseCaseProtocol.swift
//  Poentjak
//
//  Created by Shan Havilah on 08/10/24.
//

import Foundation

protocol UserStatusUseCaseProtocol {
    func updateStats(batteryLevel: Int, lastSeen: Date, lastLocation: Location) async throws
}

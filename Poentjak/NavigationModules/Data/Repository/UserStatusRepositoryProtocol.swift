//
//  BatteryHealthRepositoryProtocol.swift
//  Poentjak
//
//  Created by Shan Havilah on 07/10/24.
//

import Foundation

protocol UserStatusRepositoryProtocol {
    func updateStats(userId: String, batteryLevel: Int, lastSeen: Date, lastLocation: Location) async throws
}

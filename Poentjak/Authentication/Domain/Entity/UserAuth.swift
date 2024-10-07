//
//  UserAuth.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 25/09/24.
//

import Foundation

struct UserAuth: Codable {
    let id: String
    var name: String?
    var email: String
    var weight: Double?
    var height: Double?
    var gender: String?
    var age: Int?
    var contactNumber: String?
    var trackId: String?
    var contactName: String?
    var profileURL: String?
    var medicalRecord: String?
    var isAdmin: Bool
}

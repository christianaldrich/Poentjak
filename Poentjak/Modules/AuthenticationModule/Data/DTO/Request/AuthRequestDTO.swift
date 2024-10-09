//
//  AuthRequestDTO.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 25/09/24.
//

import Foundation

struct AuthRequestDTO: Codable {
    let email: String
    let password: String
    let isAdmin: Bool?
}

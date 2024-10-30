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
    
    let contactName: String
    let contactNumber: String
    let medicalCondition: String?
    let age: Int
    let weight: Int
    let height: Int
    
//    let gender: String
//    let 
}


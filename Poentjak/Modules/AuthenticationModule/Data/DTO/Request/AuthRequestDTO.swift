//
//  AuthRequestDTO.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 25/09/24.
//

import Foundation
import PhotosUI


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
    
    let name: String
    let gender: String
//    @CodableImage var profileURL: UIImage?
    var profileURL: String?
//    let
}


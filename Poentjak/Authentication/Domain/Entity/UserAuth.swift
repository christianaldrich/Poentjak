//
//  UserAuth.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 25/09/24.
//

import Foundation

struct UserAuth: Codable {
    let id: String
    let email: String
    let fullname: String
    let username: String
    let isAdmin: Bool
    var profileImageUrl: String?
    var bio: String?
    
}

//
//  AuthResponseDTO.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 25/09/24.
//

import Foundation

struct AuthResponseDTO: Codable {
    let id: String
    let email: String
    let fullname: String
    let username: String
    let isAdmin: Bool
    let profileImageUrl: String?
    let bio: String?
}

extension AuthResponseDTO {
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "email": email,
            "fullname": fullname,
            "username": username,
            "isAdmin": isAdmin,
            "profileImageUrl": profileImageUrl ?? "",
            "bio": bio ?? ""
        ]
    }
}

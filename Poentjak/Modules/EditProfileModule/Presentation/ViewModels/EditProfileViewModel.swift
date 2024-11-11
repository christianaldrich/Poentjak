//
//  EditProfileViewModel.swift
//  Poentjak
//
//  Created by Shan Havilah on 08/11/24.
//

import Foundation

class EditProfileViewModel: ObservableObject {
    @Published var gender: String = ""
    @Published var age: Int = 1
    @Published var weight: Int = 1
    @Published var height: Int = 1
    @Published var contactName: String = ""
    @Published var contactNumber: String = ""
    @Published var medicalCondition: String = ""
}

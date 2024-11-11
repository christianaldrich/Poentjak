//
//  HikerProfileViewModel.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 10/11/24.
//

import Foundation
import SwiftUI

class HikerProfileViewModel: ObservableObject{
    
    @Published var hikerProfile: User?
    @Published private var authViewModel: AuthViewModel
    
    private let hikerProfileUseCase: HikerProfileUseCaseProtocol
    
    init(authViewModel: AuthViewModel, hikerProfileUseCase: HikerProfileUseCaseProtocol) {
        self.authViewModel = authViewModel
        self.hikerProfileUseCase = hikerProfileUseCase
    }
    
    func fetchHikerProfile(){
        hikerProfileUseCase.fetchHikerProfile{
            [weak self] profile in
            DispatchQueue.main.async {
                self?.hikerProfile = profile
                self!.authViewModel.age = profile.age
                self!.authViewModel.name = profile.name
                self!.authViewModel.gender = profile.gender
                self!.authViewModel.medicalCondition = profile.medicalRecord ?? "GOBLOK"
                self!.authViewModel.weight = Int(profile.weight)
                self!.authViewModel.height = Int(profile.height)
            }
        }
    }
    
}

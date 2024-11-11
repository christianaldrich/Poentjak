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
    
    private let hikerProfileUseCase: HikerProfileUseCaseProtocol
    
    init(hikerProfileUseCase: HikerProfileUseCaseProtocol) {
        self.hikerProfileUseCase = hikerProfileUseCase
    }
    
    func fetchHikerProfile(){
        hikerProfileUseCase.fetchHikerProfile{
            [weak self] profile in
            DispatchQueue.main.async {
                self?.hikerProfile = profile
                
            }
        }
    }
    
}

//
//  ActiveHikersViewModel.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 07/10/24.
//

import Foundation

class ActiveHikersViewModel: ObservableObject{
    @Published var activeHikers: [EmergencyRequestModel] = []
    
    private let activeHikersUseCase: ActiveHikersUseCaseProtocol
    
    init(activeHikersUseCase: ActiveHikersUseCaseProtocol) {
        self.activeHikersUseCase = activeHikersUseCase
        fetchActiveHikers()
    }
    
    func fetchActiveHikers() {
        activeHikersUseCase.fetchActiveHikers { [weak self] requests in
            DispatchQueue.main.async {
                self?.activeHikers = requests
                //                        print("Updated active hikers: \(requests)")
            }
        }
    }
    
    
}


//
//  DefaultDueDateUseCase.swift
//  Poentjak
//
//  Created by Felicia Himawan on 02/10/24.
//

import Foundation

class DefaultDueDateUseCase: DueDateUseCaseProtocol{
    private let userRepository: UserRepositoryProtocol
    private let dueDateRepository: DueDateRepositoryProtocol
    
    init(userRepository: UserRepositoryProtocol, dueDateRepository: DueDateRepositoryProtocol) {
        self.userRepository = userRepository
        self.dueDateRepository = dueDateRepository
    }
    
    func updateDueDate(dueDate: Date) async throws {
        let userAuth = try await userRepository.fetchCurrentUser()
        
        do {
            try await dueDateRepository.updateDueDate(userId: userAuth.id, dueDate: dueDate)
        } catch {
            // Handle the error (e.g., document not found)
            print("Failed to update due date: \(error.localizedDescription)")
            throw error // Re-throw if you want to handle it further up the call stack
        }

    }
    
}


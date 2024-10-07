//
//  DueDateRepositoryProtocol.swift
//  Poentjak
//
//  Created by Felicia Himawan on 02/10/24.
//

import Foundation

protocol DueDateRepositoryProtocol {
    func updateDueDate(userId: String, dueDate: Date) async throws
}

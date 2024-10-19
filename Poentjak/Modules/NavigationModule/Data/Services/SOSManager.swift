//
//  SOSManager.swift
//  Poentjak
//
//  Created by Shan Havilah on 16/10/24.
//

import Foundation

class SOSManager: ObservableObject {
    static let shared = SOSManager()
    
    @Published var isSOS: Bool = false
}

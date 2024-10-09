//
//  NetworkManager.swift
//  macroTest1
//
//  Created by Singgih Tulus Makmud on 16/09/24.
//

import Network
import SwiftUI

class NetworkManager: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkManager")

    @Published var isConnected: Bool = false

    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
}


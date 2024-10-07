//
//  NetworkView.swift
//  MacroSprint_1
//
//  Created by Shan Havilah on 02/10/24.
//

import SwiftUI

struct NetworkView: View {
    @StateObject var networkManager = NetworkManager()
    
    var body: some View {
        Text(networkManager.isConnected ? "Connection Available" : "No Connection")
            .foregroundColor(networkManager.isConnected ? .green : .red)
            .padding()
    }
}

#Preview {
    NetworkView()
}

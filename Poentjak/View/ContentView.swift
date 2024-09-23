//
//  ContentView.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 23/09/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear{
            FetchData().fetchUsers()
        }
    }
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 23/09/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = UserViewModel()
    
    var body: some View {
        
        NavigationView {
                    List(viewModel.user, id: \.id) { user in
                        VStack(alignment: .leading) {
                            Text("ID: \(user.id)")
                            Text("Name: \(user.name)")
                            Text("Age: \(user.age)")
                            Text("Gender: \(user.gender)")
                            Text("Height: \(user.height)")
                            Text("Weight: \(user.weight)")
                            Text("Is in Danger: \(user.isDanger ? "Yes" : "No")")
                            Text("Last Seen at: \(user.lastSeen.latitude), \(user.lastSeen.longitude)")
                            
                            Button("Confirm Rescue"){
                                
                            }
                        }
                        .padding()
                    }
                    .navigationTitle("All Users")
                    .onAppear {
                        viewModel.fetchEmergency()
                    }
                }
        }

}

#Preview {
    ContentView()
}

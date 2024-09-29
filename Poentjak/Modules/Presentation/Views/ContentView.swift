//
//  ContentView.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 23/09/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = UserViewModel()
    @State private var activeEmergencies = [UserModel]()
    
    var body: some View {
        NavigationView {
                    List {
                        // Section for all users who are not in rescue
                        Section(header: Text("Hikers Need Help!")) {
                            ForEach(viewModel.user.filter { !$0.isInRescue }, id: \.id) { user in
                                VStack(alignment: .leading) {
                                    Text("ID: \(user.id)")
                                    Text("Name: \(user.name)")
                                    Text("Age: \(user.age)")
                                    Text("Gender: \(user.gender)")
                                    Text("Height: \(user.height)")
                                    Text("Weight: \(user.weight)")
                                    Text("Is in Danger: \(user.isDanger ? "Yes" : "No")")
                                    Text("Is in Rescue: \(user.isInRescue ? "Rescuing" : "Yah dicuekin")")
                                    Text("Last Seen at: \(user.lastSeen.latitude), \(user.lastSeen.longitude)")
                                    
                                    Button("Confirm Rescue") {
                                        viewModel.rescuing(id: user.id)
                                    }
                                }
                                .padding()
                            }
                        }
                        
                        // Section for active emergencies
                        Section(header: Text("Active Emergencies")) {
                            ForEach(viewModel.user.filter { $0.isInRescue }, id: \.id) { user in
                                VStack(alignment: .leading) {
                                    Text("ID: \(user.id)")
                                    Text("Name: \(user.name)")
                                    Text("Age: \(user.age)")
                                    Text("Gender: \(user.gender)")
                                    Text("Height: \(user.height)")
                                    Text("Weight: \(user.weight)")
                                    Text("Last Seen at: \(user.lastSeen.latitude), \(user.lastSeen.longitude)")
                                    Button("Finish Rescue"){
                                        
                                    }
                                }
                                .padding()
                            }
                        }
                    }
                    .navigationTitle("Ranger's View")
                    .onAppear {
                        viewModel.fetchEmergency()
                    }
                }
        
        }

}

#Preview {
    ContentView()
}


//NavigationView {
//            List(viewModel.user, id: \.id) { user in
//                VStack(alignment: .leading) {
//                    Text("ID: \(user.id)")
//                    Text("Name: \(user.name)")
//                    Text("Age: \(user.age)")
//                    Text("Gender: \(user.gender)")
//                    Text("Height: \(user.height)")
//                    Text("Weight: \(user.weight)")
//                    Text("Is in Danger: \(user.isDanger ? "Yes" : "No")")
//                    Text("Is in Rescue: \(user.isInRescue ? "Rescuing" : "Yah dicueking")")
//                    Text("Last Seen at: \(user.lastSeen.latitude), \(user.lastSeen.longitude)")
//                    
//                    Button("Confirm Rescue"){
//                        viewModel.rescuing(id: user.id)
//                    }
//                    
//                    
//                }
//                .padding()
//            }
//            .navigationTitle("All Users")
//            .onAppear {
//                viewModel.fetchEmergency()
//            }
//        }

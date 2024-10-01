//
//  ContentView.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 23/09/24.
//

import SwiftUI

struct ActiveEmergencyView: View {
    @StateObject private var viewModel = UserViewModel()
    @State private var activeEmergencies = [UserModel]()
    
    @State var selectedUser: UserModel?
    @State private var isDetailViewActive = false
    
    
    var body: some View {
        
        NavigationView {
            List {
                
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
                                selectedUser = user
                                isDetailViewActive = true
                            }
                        }
                        .padding()
                    }
                }
                
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
                                selectedUser = user
                                isDetailViewActive = true
                            }
                        }
                        .padding()
                    }
                }
                
                Text("No Active Emergencies!\nGreat Job!")
            }
            .navigationTitle("Ranger's View")
            .onAppear {
                viewModel.fetchEmergency()
            }
            .background(
                NavigationLink(
                    destination: RangerReceiveSOSAlertView(user: selectedUser),
                    isActive: $isDetailViewActive,
                    label: { EmptyView() }
                )
            )
        }
        
    }
    
}

#Preview {
    ActiveEmergencyView()
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

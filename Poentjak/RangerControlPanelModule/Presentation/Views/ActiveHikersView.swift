//
//  Untitled.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 07/10/24.
//

import SwiftUI

struct ActiveHikersView: View {
    
    @StateObject var viewModel = ActiveHikersViewModel(activeHikersUseCase: ActiveHikersUseCase(activeHikersRepository: ActiveHikersRepository()))
    
    @State var selectedUser: EmergencyRequestModel?
    @State private var isDetailViewActive = false
    
    
    var body: some View {
        NavigationStack{
            VStack {
                if viewModel.activeHikers.isEmpty {
                    Text("No active hikers")
                        .font(.headline)
                        .padding()
                } else {
                    
                    List(viewModel.activeHikers, id: \.id) { hiker in
                        NavigationLink(value:hiker){
                            VStack(alignment: .leading) {
                                Text(hiker.user?.name ?? "Unknown Hiker")
                                    .font(.headline)
                                Text("Emergency Type: \(hiker.emergencyType)")
                                Text("Status: \(hiker.emergencyStatus)")
                                Text("\(hiker.sessionDone ? "Udah Kelar" : "Belom Kelar")")
                                
                            }
                            .padding(.vertical)
                        }
                    }
                    
                    .listStyle(PlainListStyle())
                }
            }
            
            .navigationTitle("Active Hikers")
            .navigationDestination(for: EmergencyRequestModel.self){hiker in
                ActiveHikersDetailView(hiker: hiker)
            }
        }
    }
}




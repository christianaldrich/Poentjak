//
//  Untitled.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 07/10/24.
//

import SwiftUI

struct ActiveHikersView: View {
    
    @StateObject var viewModel = ActiveHikersViewModel(activeHikersUseCase: ActiveHikersUseCase(activeHikersRepository: ActiveHikersRepository(), userRepository: DefaultUserRepository()))
    
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
                        
                        Button(action: {
                            // Set the selected user and present the modal
                            selectedUser = hiker
                            isDetailViewActive = true
                        }) {
                            ActiveHikersCardComponent(name: hiker.user?.name ?? "",
                                                      gender: hiker.user?.gender ?? "",
                                                      dueDate: hiker.dueDate,
                                                      viewModel: viewModel)
                            .padding(.vertical)
                        }
                        .buttonStyle(PlainButtonStyle())
                        //                        NavigationLink(value:hiker){
                        //                            VStack(alignment: .leading) {
                        //                                ActiveHikersCardComponent(name: hiker.user?.name ?? "", gender: hiker.user?.gender ?? "", dueDate: hiker.dueDate, viewModel: viewModel)
                        //                            }
                        //                            .padding(.vertical)
                        //                        }
                        //                        .buttonStyle(PlainButtonStyle())
                        
                    }
                    
                    .listStyle(PlainListStyle())
                }
            }
            
            .navigationTitle("Active Hikers: \(viewModel.activeHikers.count)")
            //            .navigationDestination(for: EmergencyRequestModel.self){hiker in
            //                ActiveHikersDetailView(hiker: hiker)
            //            }
            .sheet(item: $selectedUser) { hiker in
                ActiveHikersDetailView(hiker: hiker)
            }
        }
    }
}




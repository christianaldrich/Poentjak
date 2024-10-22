//
//  AssignRangersView.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 03/10/24.
//

import SwiftUI

struct AssignRangersView: View {
    @StateObject var viewModel: AdminEmergencyViewModel
    @State private var newRangerName: String = ""
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                
                Text("Who’s in charge of the rescue?")
                    .font(.title2Emphasized)
                
                List {
                    ForEach(viewModel.availableRangers) { ranger in
                      
                                HStack {
                                    Text(ranger.name)
                                        .font(.calloutRegular)

                                    Spacer()

                                    Button(action: {
                                        if viewModel.selectedRangerIds.contains(ranger.id) {
                                            // Deselect the ranger
                                            viewModel.selectedRangerIds.removeAll { $0 == ranger.id }
                                            viewModel.selectedRangerNames.removeAll { $0 == ranger.name }
                                        } else {
                                            viewModel.selectedRangerIds.append(ranger.id)
                                            viewModel.selectedRangerNames.append(ranger.name)
                                        }
                                    }) {
                                        HStack {
                                            if viewModel.selectedRangerIds.contains(ranger.id) {
                                                Image.AdminIcon.checkboxChecked
                                            } else {
                                                Image.AdminIcon.checkboxUnchecked
                                            }
                                        }
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                                .padding(.vertical, 24)
                            
                        
                        .listRowInsets(EdgeInsets())
                    }

                }
                .listStyle(PlainListStyle())
                
                
                if viewModel.selectedRangerIds == [] {
                    CustomPrimaryButtonComponent(state: .disabled, text: "Select Rangers"){
                        
                    }
                }

                else if let emergencyRequest = viewModel.emergencyRequest, emergencyRequest.emergencyStatus == .ongoing {
                    CustomPrimaryButtonComponent(state: .enabled, text: "Save") {
                        Task {
                            if let emergencyId = viewModel.emergencyRequest?.id {
                                await viewModel.assignRangers(rangerIds: viewModel.selectedRangerIds)
                            }
                        }
                        dismiss()
                    }
                } else {
                    CustomPrimaryButtonComponent(state: .enabled, text: "Select Rangers"){
                        dismiss()
                }
                
                }
                
            }
            .padding(24)
            
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) { 
                NavigationLink {
                    EditRangersView(viewModel: viewModel)
                } label: {
                    Text("Edit")
                }
            }
            
        }
    }
}

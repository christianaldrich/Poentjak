//
//  EditRangersView.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 20/10/24.
//

import SwiftUI

struct EditRangersView: View {
    @StateObject var viewModel: AdminEmergencyViewModel
    @State private var newRangerName: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text("Edit Rangers")
                .font(.title2Emphasized)
            
            List {
                ForEach(viewModel.availableRangers) { ranger in
                    VStack{
                        
                        HStack {
                            TextField("Ranger Name", text: Binding(
                                get: { ranger.name },
                                set: { newName in
                                    var updatedRanger = ranger
                                    updatedRanger.name = newName
                                    Task {
                                        await viewModel.editRanger(updatedRanger)
                                    }
                                })
                            )
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            Spacer()
                            
                            Button(action: {
                                Task {
                                    await viewModel.deleteRanger(ranger)
                                }
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                                    .frame(width: 24, height: 24)
                                    .contentShape(Rectangle())
                            }
                            .buttonStyle(.borderless)
                    
                        }
                        .padding(.bottom, 12)
                        .padding(.top, 20)
                        Divider()
                            .padding(0)
                    }
                    .listRowInsets(EdgeInsets())
                    
                }
                .listRowSeparator(.hidden)
                
                HStack {
                    TextField("Add new ranger", text: $newRangerName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        Task {
                            if !newRangerName.isEmpty {
                                await viewModel.addNewRanger(name: newRangerName)
                                newRangerName = ""
                            }
                        }
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.blue)
                    }
                    .buttonStyle(.borderless)
                }
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
                .padding(.top, 20)
                
                
                
            }
            
            .listStyle(PlainListStyle())
            
            
            CustomPrimaryButtonComponent(state: .enabled, text: "Done Editing"){
                dismiss()
            }
        }
        .padding(24)
    }
    
    
}

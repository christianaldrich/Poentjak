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
    @State private var isEditing: Bool = false
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Who’s in charge of the rescue?")
                    .font(.headline)
                    .padding()

                List {
                    ForEach(viewModel.availableRangers) { ranger in
                        HStack {
                            if isEditing {
                                // Editing mode: TextField to edit ranger name
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
                                .padding()

                                Spacer()

                                Button(action: {
                                    Task {
                                        await viewModel.deleteRanger(ranger)
                                    }
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                            } else {
                                // Selection mode: Toggle for selecting rangers
                                Button(action: {
                                    if viewModel.selectedRangerIds.contains(ranger.id) {
                                        // Deselect the ranger
                                        viewModel.selectedRangerIds.removeAll { $0 == ranger.id }
                                    } else {
                                        // Select the ranger
                                        viewModel.selectedRangerIds.append(ranger.id)
                                    }
                                }) {
                                    HStack {
                                        Text(ranger.name)
                                            .foregroundColor(.primary)

                                        Spacer()

                                        // Indicate if the ranger is selected
                                        if viewModel.selectedRangerIds.contains(ranger.id) {
                                            Image(systemName: "checkmark")
                                                .foregroundColor(.green)
                                        }
                                    }
                                    .padding()
                                    .background(viewModel.selectedRangerIds.contains(ranger.id) ? Color.green.opacity(0.2) : Color.clear)
                                    .cornerRadius(8)
                                }
                                .buttonStyle(PlainButtonStyle()) // Prevent default button styling
                            }
                        }
                    }

                    HStack {
                        TextField("Add new ranger", text: $newRangerName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())

                        Spacer()

                        Button(action: {
                            Task {
                                if !newRangerName.isEmpty {
                                    await viewModel.addNewRanger(name: newRangerName)
                                    newRangerName = ""
                                }
                            }
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.green)
                                .font(.system(size: 24))
                        }
                    }
                }

                Spacer()

                // Button to toggle editing mode
                Button(action: {
                    isEditing.toggle()
                }) {
                    Text(isEditing ? "Done Editing" : "Edit Rangers")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(isEditing ? Color.gray : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.bottom, 16)

                // New Button to Assign Rangers to Emergency
                Button(action: {
                    Task {
                        if (viewModel.emergencyRequest?.id) != nil {
                            await viewModel.assignRangers(rangerIds: viewModel.selectedRangerIds)
                            dismiss()
                        }
                    }
                }) {
                    Text("Assign Rangers to Emergency")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.bottom, 16)
            }
            .navigationTitle("Ranger Assignment")
        }
    }
}

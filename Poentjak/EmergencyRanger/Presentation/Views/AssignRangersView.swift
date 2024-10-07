//
//  AssignRangersView.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 03/10/24.
//

import SwiftUI

struct AssignRangersView: View {
    @StateObject var viewModel: AdminEmergencyViewModel

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Who’s in charge of the rescue?")
                    .font(.headline)
                    .padding()

                List(viewModel.availableRangers) { ranger in
                    Button(action: {
                        toggleSelection(for: ranger)
                    }) {
                        HStack {
                            Text(ranger.name)
                                .foregroundColor(.primary)

                            Spacer()

                            if viewModel.selectedRangerIds.contains(ranger.id) {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.green)
                            }
                        }
                    }
                }

                Spacer()

                Button("Submit Selection") {
                    Task {
                        await viewModel.assignRangers(rangerIds: Array(viewModel.selectedRangerIds))
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)
                .disabled(viewModel.selectedRangerIds.isEmpty)
            }
            .navigationTitle("Ranger Assignment")
        }
    }

    private func toggleSelection(for ranger: Ranger) {
        if viewModel.selectedRangerIds.contains(ranger.id) {
            viewModel.selectedRangerIds.removeAll(where: { $0 == ranger.id })
        } else {
            viewModel.selectedRangerIds.append(ranger.id)
        }
    }
}

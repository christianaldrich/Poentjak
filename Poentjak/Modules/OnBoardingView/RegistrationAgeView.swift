//
//  RegistrationOnBoardingView.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 29/10/24.
//

import SwiftUI

struct RegistrationAgeView: View {
    @StateObject var viewModel: AuthViewModel
    @State private var expandedIndex: Int? = nil
    @State private var navigateNext = false 
    
    var isFormFilled: Bool {
        !viewModel.age.isEmpty && !viewModel.weight.isEmpty && !viewModel.height.isEmpty
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("We need some of your biodata for emergency situations")
                    .font(.title3Emphasized)
                    .foregroundStyle(Color.primaryGreen500)
                    .padding(.horizontal, 16)
                
                List(0..<3, id: \.self) { idx in
                    DisclosureGroup(
                        isExpanded: Binding(
                            get: { expandedIndex == idx },
                            set: { expandedIndex = $0 ? idx : nil }
                        )
                    ) {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                if idx == 0 {
                                    Text("Age: \(viewModel.age.isEmpty ? "..." : viewModel.age)")
                                    Spacer()
                                    TextField("Enter Age", text: $viewModel.age)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .frame(width: 100)
                                    
                                } else if idx == 1 {
                                    Text("Weight: \(viewModel.weight.isEmpty ? "..." : viewModel.weight)")
                                    Spacer()
                                    TextField("Enter Weight", text: $viewModel.weight)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .frame(width: 100)
                                    
                                } else if idx == 2 {
                                    Text("Height: \(viewModel.height.isEmpty ? "..." : viewModel.height)")
                                    Spacer()
                                    TextField("Enter Height", text: $viewModel.height)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .frame(width: 100)
                                }
                            }
                            .padding(.vertical, 16)
                        }
                        .listRowSeparator(.hidden)
                    } label: {
                        HStack {
                            Text(idx == 0 ? "Age" :
                                    idx == 1 ? "Weight, kg" :
                                    "Height, cm"
                            )
                            .font(Font.subheadlineRegular)
                            .foregroundStyle(Color.primaryGreen500)
                            Spacer()
                            Text(idx == 0 ? (viewModel.age.isEmpty ? "21" : viewModel.age) :
                                    idx == 1 ? (viewModel.weight.isEmpty ? "72" : viewModel.weight) :
                                    (viewModel.height.isEmpty ? "175" : viewModel.height))
                            .font(Font.bodyEmphasized)
                            .foregroundStyle(idx == 0 ? (viewModel.age.isEmpty ? Color.neutralGrayLightGray : Color.primaryGreen500) :
                                                idx == 1 ? (viewModel.weight.isEmpty ? Color.neutralGrayLightGray : Color.primaryGreen500) :
                                                (viewModel.height.isEmpty ? Color.neutralGrayLightGray : Color.primaryGreen500))
                                
                                
                        }
                        .alignmentGuide(.listRowSeparatorTrailing) { d in
                            d[.trailing] + 16
                        }
                        .padding(.vertical, 16)
                    }
                    .animation(.easeOut, value: expandedIndex)
                    .accentColor(.primaryGreen500)
                }
                .shadow(color: .gray.opacity(0.5), radius: 4, x: 0, y: 2)
                .scrollContentBackground(.hidden)
                
                Spacer()
                
                // NavigationLink with isActive Binding
                NavigationLink(destination: RegistrationEmergencyContactView(viewModel: viewModel), isActive: $navigateNext) {
                    EmptyView() // Link is hidden but activated by button
                }
                
                CustomLargeButtonComponent(state: isFormFilled ? .enabled : .disabled, text: "Next") {
                    if isFormFilled {
                        navigateNext = true // Trigger navigation only if form is filled
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

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
        viewModel.age > 2 && viewModel.weight > 2 && viewModel.height > 2
    }
    
    var body: some View {
//        NavigationStack {
            VStack(alignment: .leading) {
                Spacer().frame(height: 100)
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
                        VStack {
                            HStack {
                                Spacer()
                                if idx == 0 {
                                    CustomWheelComponent(wheelType: .age, selectedNumber: $viewModel.age)
                                } else if idx == 1 {
                                    CustomWheelComponent(wheelType: .weight, selectedNumber: $viewModel.weight)
                                } else if idx == 2 {
                                    CustomWheelComponent(wheelType: .height, selectedNumber: $viewModel.height)
                                }
                                Spacer()
                            }
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
                            Text(idx == 0 ? "\(viewModel.age > 0 ? "\(viewModel.age)" : "21")" :
                                  idx == 1 ? "\(viewModel.weight > 0 ? "\(viewModel.weight)" : "72")" :
                                  "\(viewModel.height > 0 ? "\(viewModel.height)" : "175")")
                            .font(Font.bodyEmphasized)
                            .foregroundStyle(Color.primaryGreen500)
                        }
                        .padding(.vertical, 16)
                        .padding(.horizontal, 16)
                        .alignmentGuide(.listRowSeparatorTrailing) { d in
                            d[.trailing] + 16
                        }
                    }
                    .padding(.horizontal, 16) // Consistent padding for each row
                    .animation(.easeOut, value: expandedIndex)
                    .accentColor(.primaryGreen500)
                }
                .shadow(color: .gray.opacity(0.5), radius: 4, x: 0, y: 2)
                .scrollContentBackground(.hidden)
                
                Spacer()
                
                // NavigationLink is no longer needed here
                CustomLargeButtonComponent(state: isFormFilled ? .enabled : .disabled, text: "Next") {
                    if isFormFilled {
                        viewModel.currentIndex += 1
                        navigateNext = true
                    }
                }
                .padding(.horizontal, 16)
            }
            .navigationDestination(isPresented: $navigateNext) {
                RegistrationEmergencyContactView(viewModel: viewModel) 
            }
//        }
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .topBarLeading){
                BackButtonComponent{
                    viewModel.currentIndex -= 1
                }
            }
        }
    }
}

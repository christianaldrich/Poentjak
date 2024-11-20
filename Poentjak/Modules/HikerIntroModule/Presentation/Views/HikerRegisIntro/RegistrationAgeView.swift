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
        viewModel.ageInteracted && viewModel.weightInteracted && viewModel.heightInteracted
    }

    private func getDisplayText(for index: Int) -> String {
        switch index {
        case 0:
            return viewModel.ageInteracted ? "\(viewModel.age)" : "21"
        case 1:
            return viewModel.weightInteracted ? "\(viewModel.weight)" : "72"
        case 2:
            return viewModel.heightInteracted ? "\(viewModel.height)" : "175"
        default:
            return ""
        }
    }

    private func getTextColor(for index: Int) -> Color {
        switch index {
        case 0:
            return viewModel.ageInteracted ? Color.primaryGreen500 : Color.neutralGrayLightGray
        case 1:
            return viewModel.weightInteracted ? Color.primaryGreen500 : Color.neutralGrayLightGray
        case 2:
            return viewModel.heightInteracted ? Color.primaryGreen500 : Color.neutralGrayLightGray
        default:
            return .gray
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            Spacer().frame(height: 100)

            Text("We need some of your biodata for emergency situations")
                .font(.title3Emphasized)
                .foregroundStyle(Color.primaryGreen500)
                .padding(.horizontal, 24)

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
                                    .onChange(of: viewModel.age) {
                                        viewModel.ageInteracted = true
                                    }
                            } else if idx == 1 {
                                CustomWheelComponent(wheelType: .weight, selectedNumber: $viewModel.weight)
                                    .onChange(of: viewModel.weight) {
                                        viewModel.weightInteracted = true
                                    }
                            } else if idx == 2 {
                                CustomWheelComponent(wheelType: .height, selectedNumber: $viewModel.height)
                                    .onChange(of: viewModel.height) {
                                        viewModel.heightInteracted = true
                                    }
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
                        Text(getDisplayText(for: idx))
                            .font(Font.bodyEmphasized)
                            .foregroundColor(getTextColor(for: idx))
                    }
                    .padding(.vertical, 16)
                    //.padding(.horizontal, 16)
                    .alignmentGuide(.listRowSeparatorTrailing) { d in
                        d[.trailing] + 16
                    }
                }
                //.padding(.horizontal, 24) // Consistent padding for each row
                .animation(.easeOut, value: expandedIndex)
                .accentColor(.primaryGreen500)
            }
            .padding(.horizontal, 8)
            .customShadow()
            //.scrollDisabled(true)
            .scrollContentBackground(.hidden)

            Spacer()

            CustomLargeButtonComponent(state: isFormFilled ? .enabled : .disabled, text: "Next") {
                if isFormFilled {
                    viewModel.currentIndex += 1
                    navigateNext = true
                }
            }
            .padding(.horizontal, 24)
        }
        .padding(.vertical)
        .navigationDestination(isPresented: $navigateNext) {
            RegistrationEmergencyContactView(viewModel: viewModel)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButtonComponent {
                    viewModel.currentIndex -= 1
                }
            }
        }
    }
}

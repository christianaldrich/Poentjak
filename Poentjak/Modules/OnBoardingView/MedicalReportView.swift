//
//  MedicalReportView.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 30/10/24.
//

import SwiftUI

import SwiftUI

struct MedicalReportView: View {
    @State private var medicalCondition: String = ""
    @State private var navigateNext = false
    
    var body: some View {
        
            VStack(alignment: .leading, spacing: 16) {
                Text("Do you have any specific medicinal needs? (optional)")
                    .font(.title3Emphasized)
                    .foregroundStyle(Color.primaryGreen500)
                    .padding(.horizontal, 16)
                
                VStack(alignment: .leading, spacing: 4) {
                    TextField("Enter Medical Condition (optional)", text: $medicalCondition)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 16)
                    
                    Text("e.g., Asthma")
                        .font(.footnoteRegular)
                        .foregroundColor(.neutralGrayTertiaryGray)
                        .padding(.horizontal, 16)
                }
                
                Spacer()
                
//                NavigationLink(destination: FinalView(), isActive: $navigateNext) {
//                    EmptyView()
//                }
                
                CustomLargeButtonComponent(state: .enabled, text: "Finish") {
                    navigateNext = true
                    //usecase
                }
                .padding(.horizontal, 16)
            }
        }
    
}

#Preview {
    MedicalReportView()
}


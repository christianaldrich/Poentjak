//
//  ProfileDescComponent.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 10/11/24.
//

import SwiftUI

struct ProfileDescComponent: View {
    
    var gender: String
    var age: Int
    var weight: Double
    var height: Double
    var medicalCondition: String
    var emergencyContactName: String
    var emergencyContactNumber: String
    
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(Color.white)
                .frame(width: 340, height: 347)
                .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 2)
                .shadow(color: Color.black.opacity(0.02), radius: 6, x: 0, y: 0)
            
            VStack{
                HStack{
                    Text("Gender")
                        .font(.subheadlineRegular)
                    Spacer()
                    Text("\(gender)")
                        .font(.bodyEmphasized)
                        .foregroundStyle(Color.primaryGreen500)
                }
                .padding(9)
                Divider()
                
                HStack{
                    Text("Age")
                        .font(.subheadlineRegular)
                    Spacer()
                    Text("\(age)")
                        .font(.bodyEmphasized)
                        .foregroundStyle(Color.primaryGreen500)
                }
                .padding(9)
                Divider()
                
                HStack{
                    Text("Weight, kg")
                        .font(.subheadlineRegular)
                    Spacer()
                    Text(String(format: "%.2f", weight))
                        .font(.bodyEmphasized)
                        .foregroundStyle(Color.primaryGreen500)
                }
                .padding(9)
                Divider()
                
                HStack{
                    Text("Height, cm")
                        .font(.subheadlineRegular)
                    Spacer()
                    Text(String(format: "%.2f", height))
                        .font(.bodyEmphasized)
                        .foregroundStyle(Color.primaryGreen500)
                }
                .padding(9)
                Divider()
                
                HStack{
                    Text("Medical Condition")
                        .font(.subheadlineRegular)
                    Spacer()
                    Text("\(gender)")
                        .font(.bodyEmphasized)
                        .foregroundStyle(Color.primaryGreen500)
                }
                .padding(9)
                Divider()
                
                HStack{
                    VStack(alignment: .leading){
                        Text("Emergency Contact")
                            .font(.subheadlineRegular)
                        Text("\(emergencyContactName)")
                            .font(.footnoteRegular)
                            .foregroundStyle(Color.neutralGrayTertiaryGray)
                    }
                    Spacer()
                    Text("\(emergencyContactNumber)")
                        .font(.bodyEmphasized)
                        .foregroundStyle(Color.primaryGreen500)
                }
                .padding(9)
                
                
            }
            .foregroundStyle(Color.primaryGreen500)
            .frame(maxWidth: 340, maxHeight: 347)
        }
        .padding()
    }
}

//#Preview {
//    ProfileDescComponent(gender: "male")
//}

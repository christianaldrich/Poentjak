//
//  CustomLabelGeneral.swift
//  Poentjak
//
//  Created by Felicia Himawan on 17/10/24.
//

import SwiftUI

struct CustomLabelGeneral: View {
    enum LabelType {
        case noFill
        case hikerDetailData(type: HikerDetailDataType)
        case hikerDetailDate(date: String)
        case mdpl(altitude: Int)
        case extendOverdue(time: String)
    }
    
    let type: LabelType
    
    var body: some View {
        switch type {
        case .noFill:
            // HStack with icon and text
            HStack (spacing: 10){
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundColor(Color.primaryGreen500)
                
                Text("Add new ranger")
                    .font(.subheadlineRegular)
                    .foregroundColor(.primaryGreen500)
            }
            
        case .hikerDetailData(let data):
            VStack (alignment: .leading){
                HStack {
                    Text(data.title)
                        .font(.footnoteRegular)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    data.icon
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundColor(Color.primaryGreen500)
                }
                Text(data.value)
                    .font(.title3Emphasized)
                    .foregroundColor(Color.neutralBlack)
                +
                Text(data.unit)
                    .font(.calloutEmphasized)
                    .foregroundColor(Color.neutralBlack)
                
            }
            .frame(maxWidth: 86)
            
        case .hikerDetailDate(let date):
            // Only text for date detail
            Text("Due: \(date)")
                .font(.body)
                .foregroundColor(.black)
            
        case .mdpl(let altitude):
            Text("\(altitude) MDPL")
                .font(.caption1Emphasized)
                .foregroundColor(Color.primaryGreen500)
                .padding(.horizontal, 12)
                .padding(.vertical, 2)
                .background(Color.primaryLightGreen)
                .cornerRadius(4)
            
        case .extendOverdue(time: let time):
            HStack(spacing: 10){
                Image(systemName: "clock.badge.exclamationmark.fill")
                    .resizable()
                    .frame(width: 18, height: 16)
                    .foregroundColor(Color.customLabelsReminderIconRed)
                
                Text("\(time) left till overdue, ")
                    .font(.caption1Regular)
                    .foregroundColor(Color.customLabelsReminderTextRed)
                +
                Text("extend?")
                    .font(.caption1Emphasized)
                    .foregroundColor(Color.customLabelsReminderTextRed)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color.customLabelsReminderBgRed)
            .cornerRadius(4)
        }
    }
    
    //enum buat hiker detail data
    enum HikerDetailDataType {
        case age(Int)
        case weight(Int)
        case height(Int)
        
        var title: String {
            switch self {
            case .age:
                return "Age"
            case .weight:
                return "Weight"
            case .height:
                return "Height"
            }
        }
        
        var value: String {
            switch self {
            case .age(let value):
                return "\(value) "
            case .weight(let value):
                return "\(value) "
            case .height(let value):
                return "\(value) "
            }
        }
        
        var unit: String {
            switch self {
            case .age:
                return "years"
            case .weight:
                return "kg"
            case .height:
                return "cm"
            }
        }
        
        
        var icon: Image {
            switch self {
            case .age:
                return Image.LabelIcon.age
            case .weight:
                return Image.LabelIcon.weight
            case .height:
                return Image.LabelIcon.height
            }
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        CustomLabelGeneral(type: .noFill)
        CustomLabelGeneral(type: .hikerDetailData(type: .age(25)))
        CustomLabelGeneral(type: .hikerDetailData(type: .weight(60)))
        CustomLabelGeneral(type: .hikerDetailData(type: .height(170)))
        CustomLabelGeneral(type: .hikerDetailDate(date: "Tue, 24 Sep 19.00"))
        CustomLabelGeneral(type: .mdpl(altitude: 3000))
        CustomLabelGeneral(type: .extendOverdue(time: "30 mins"))
    }
    .padding()
}

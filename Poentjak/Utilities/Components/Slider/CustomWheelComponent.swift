//
//  CustomWheelComponent.swift
//  Poentjak
//
//  Created by Shan Havilah on 29/10/24.
//

import SwiftUI

enum WheelPicker {
    case age
    case weight
    case height
    
    var postFix: String {
        switch self {
        case .age:
            return "years old"
        case .weight:
            return "kg"
        case .height:
            return "cm"
        }
    }
    
    var title: String {
        switch self {
        case .age:
            return "How old are you?"
        case .weight:
            return "How much do you weigh?"
        case .height:
            return "How tall are you?"
        }
    }
    
    var range: [Int] {
            switch self {
            case .age:
                return Array(1...150)
            case .weight:
                return Array(1...150)
            case .height:
                return Array(1...250)
            }
        }
}

struct CustomWheelComponent: View {
    var wheelType: WheelPicker
    @Binding var selectedNumber: Int

    var body: some View {
        VStack {
            // Wheel picker
            HStack {
                Picker("Select a number", selection: $selectedNumber) {
                    ForEach(wheelType.range, id: \.self) { number in
                        // Only show postfix for the selected item
                        if number == selectedNumber {
                            Text("\(number)").tag(number)
                                .font(.largeTitleEmphasized)
                                .foregroundColor(Color.primaryGreen500)
                            
                        } else {
                            Text("\(number)").tag(number)
                                .font(.title2Regular)
                                .foregroundColor(Color.primaryGreen500)
                        }
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 100, height: 215)
                
                Text("\(wheelType.postFix)")
                    .font(.bodyEmphasized)
                    .foregroundColor(Color.primaryGreen500)
            }
        }
        .padding()
    }
}

#Preview {
//    CustomWheelComponent(wheelType: .weight)
//    CustomWheelComponent(wheelType: .age)
//    CustomWheelComponent(wheelType: .height)
}

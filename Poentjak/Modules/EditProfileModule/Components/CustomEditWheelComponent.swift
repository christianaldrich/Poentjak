//
//  CustomEditWheelComponent.swift
//  Poentjak
//
//  Created by Shan Havilah on 08/11/24.
//

import SwiftUI

struct CustomEditWheelComponent: View {
    var wheelType: WheelPicker
    @Binding var selectedNumber: Int
    
    // Create an array of integers from 1 to 150
    let numbers = Array(1...200)

    var body: some View {
        VStack {
            // Wheel picker
            HStack {
                Picker("Select a number", selection: $selectedNumber) {
                    ForEach(numbers, id: \.self) { number in
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
                .frame(width: 100)
                .frame(maxHeight: 130)
                
                Text("\(wheelType.postFix)")
                    .font(.bodyEmphasized)
                    .foregroundColor(Color.primaryGreen500)
            }
        }
        .padding()
    }
}

struct CustomEditWheelComponent_Previews: PreviewProvider {
    @State static private var previewSelectedNumber = 50 // Sample number for preview

    static var previews: some View {
        CustomEditWheelComponent(
            wheelType: .age, // Replace with appropriate initializer for `WheelPicker`
            selectedNumber: $previewSelectedNumber
        )
        .previewLayout(.sizeThatFits) // Optional: adjust preview layout
    }
}

//
//  CustomDateSliderComponent.swift
//  Poentjak
//
//  Created by Shan Havilah on 01/11/24.
//

import SwiftUI

struct CustomDateSliderComponent: View {
    @Binding var selectedDate: Date
    
    var body: some View {
        VStack {
            DatePicker(
                "",
                selection: $selectedDate,
                displayedComponents: [.date, .hourAndMinute]
            )
            .datePickerStyle(.wheel)
            .labelsHidden()
            .frame(maxWidth: .infinity)
            .padding()
        }
    }
}

//#Preview {
//    CustomDateSliderComponent()
//}

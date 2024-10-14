//
//  EditDueDateView.swift
//  Poentjak
//
//  Created by Felicia Himawan on 10/10/24.
//

import SwiftUI

struct EditDueDateView: View {
    @StateObject var viewModel: EmergencyProsesViewModel
    @EnvironmentObject var navigationManager: NavigationManager
    @State private var selectedDate: Date = Date()
    
//    init(viewModel: EmergencyProsesViewModel, navigationManager: NavigationManager) {
//        _viewModel = StateObject(wrappedValue: viewModel)
//        _navigationManager = StateObject(wrappedValue: navigationManager)
//        _selectedDate = State(initialValue: viewModel.dueDate)
//    }
    
    
    var body: some View {
        VStack {
                   // DatePicker for selecting date and time
                   DatePicker("", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                       .datePickerStyle(WheelDatePickerStyle()) // Customize the style here
                       .padding()
                   
                   // Show the selected date
                   Text("Selected Date: \(selectedDate.formatted(date: .abbreviated, time: .shortened))")
                       .padding()
                   
                   // Save button
                   Button(action: {
                       // Assign the selected date to the view model and call updateDueDate
                       viewModel.dueDate = selectedDate
                       Task {
                           await viewModel.updateDueDate()
                           // After saving, navigate back to the root
                           navigationManager.popToRoot()
                       }
                   }) {
                       Text("Save")
                           .frame(maxWidth: .infinity)
                           .padding()
                           .background(Color.blue)
                           .foregroundColor(.white)
                           .cornerRadius(8)
                   }
                   .padding()
                   
                   Spacer()
               }
               .navigationTitle("Edit Due Date")
               .padding()
               .onAppear {
                           // Set the selectedDate when the view appears
                           selectedDate = viewModel.dueDate
                       }
           }
    }


#Preview {
    EditDueDateView(viewModel: EmergencyProsesViewModel())
        .environmentObject(NavigationManager())
}

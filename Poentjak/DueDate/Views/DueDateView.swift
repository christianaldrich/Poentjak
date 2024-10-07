//
//  DueDateView.swift
//  Poentjak
//
//  Created by Felicia Himawan on 02/10/24.
//

import SwiftUI

struct DueDateView: View {
    @StateObject var viewModel = DueDateViewModel()
    
    @State private var showDatePicker = false
    @State private var showTimePicker = false
    @State private var navigateToEmergencyProcess = false // State for navigation
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Tell us when you will be back")
                    .font(.title2)
                    .bold()
                    .padding(.bottom, 11)
                
                Text("This information will help us alert \n rangers in case of emergency")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                
                // Date Picker Button
                Button(action: {
                    showDatePicker.toggle()
                    showTimePicker = false // Close time picker if open
                }) {
                    Text(viewModel.dueDateFormatted(format: "MMMM d, yyyy"))
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                }
                
                // Time Picker Button
                Button(action: {
                    showTimePicker.toggle()
                    showDatePicker = false // Close date picker if open
                }) {
                    Text(viewModel.dueTimeFormatted())
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                }
                
                
                //            DatePicker("Select Date", selection: $viewModel.dueDate, displayedComponents: .date)
                //                .datePickerStyle(GraphicalDatePickerStyle())
                //                .padding()
                //
                //            DatePicker("Select Time", selection: $viewModel.dueDate, displayedComponents: .hourAndMinute)
                //                .datePickerStyle(WheelDatePickerStyle())
                //                .padding()
                
                // Picker Area
                if showDatePicker {
                    DatePicker("Select Date", selection: $viewModel.dueDate, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .labelsHidden()
                        .transition(.opacity)
                } else if showTimePicker {
                    DatePicker("Select Time", selection: $viewModel.dueDate, displayedComponents: .hourAndMinute)
                        .datePickerStyle(WheelDatePickerStyle())
                        .labelsHidden()
                        .transition(.opacity)
                }
                
                Button(action: {
                    Task {
                        await viewModel.createEmergencyHiking()
                        navigateToEmergencyProcess = true // Trigger navigation after the task
                    }
                }) {
                    Text("Start Tracking")
                        .font(.headline)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top)
                
                // Use NavigationLink to navigate when the state changes
                .navigationDestination(isPresented: $navigateToEmergencyProcess) {
                    EmergencyProsesView()
                }
                
                //                Button(action: {
                //                    Task {
                //                        //                    await viewModel.updateDueDate()
                //                        await viewModel.createEmergencyHiking()
                //                    }
                //                }) {
                //                    Text("Start Tracking")
                //                        .font(.headline)
                //                        .padding()
                //                        .background(Color.green)
                //                        .foregroundColor(.white)
                //                        .cornerRadius(10)
                //                }
                
            }
            .padding()
        }
        
    }
}

#Preview {
    DueDateView()
}

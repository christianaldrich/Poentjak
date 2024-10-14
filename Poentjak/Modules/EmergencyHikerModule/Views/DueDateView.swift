//
//  DueDateView.swift
//  Poentjak
//
//  Created by Felicia Himawan on 02/10/24.
//

import SwiftUI

struct DueDateView: View {
    @StateObject var viewModel = DueDateViewModel()
    @StateObject var viewModelTest = EmergencyProsesViewModel()

    
    @State private var showDatePicker = false
    @State private var showTimePicker = false
    @State private var navigateToEmergencyProcess = false // State for navigation
    @State private var navigateToTracking = false
    
    var body: some View {
        
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
            
//            NavigationLink(value: ){
//                Text("Start Tracking")
//                    .font(.headline)
//                    .padding()
//                    .background(Color.green)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//            .onTapGesture {
//                Task{
//                    await viewModelTest.createEmergencyHiking()
//                }
//            }
            
            
            Button(action: {
//                DispatchQueue.main.async{
                    Task {
                        await viewModelTest.createEmergencyHiking()
       //                 viewModelTest.emergencySessionActive = true
    //                    await viewModel.createEmergencyHiking()
    //                    navigateToEmergencyProcess = true
                        // Trigger navigation after the task
                        //                        navigateToTracking = true
                    }
//                }
               
            }) {
                Text("Start Tracking")
                    .font(.headline)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top)
                        
//                            .navigationDestination(isPresented: $navigateToTracking) {
//                                UserNavigateView()
//                            }
//            
//                            Button(action: {
//                                Task {
//                                    //                    await viewModel.updateDueDate()
//                                    await viewModel.createEmergencyHiking()
//                                }
//                            }) {
//                                Text("Start Tracking")
//                                    .font(.headline)
//                                    .padding()
//                                    .background(Color.green)
//                                    .foregroundColor(.white)
//                                    .cornerRadius(10)
//                            }
            
        }
//        .navigationDestination(isPresented: $navigateToEmergencyProcess) {
//            EmergencyProsesView()
//        }
        .padding()
    }
    
    
}

#Preview {
    DueDateView()
}

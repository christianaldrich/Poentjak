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
    @State var trackLocation: String
    
    @EnvironmentObject var mountainViewModel : MountainsTracksViewModel
    
    @EnvironmentObject var navigationManager : MountainNavigationManager
    
    var body: some View {
        
            VStack {
                
                Text("Track Name: \(trackLocation)")
                
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
                
                if showDatePicker {
                    DatePicker("Select Date", selection: $viewModelTest.dueDate, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .labelsHidden()
                        .transition(.opacity)
                } else if showTimePicker {
                    DatePicker("Select Time", selection: $viewModelTest.dueDate, displayedComponents: .hourAndMinute)
                        .datePickerStyle(WheelDatePickerStyle())
                        .labelsHidden()
                        .transition(.opacity)
                }
                
                Button(action: {
                    
                    Task{
                        mountainViewModel.selectedTrackLocation = trackLocation
                        await viewModelTest.createEmergencyHiking(trackId: trackLocation)
                        mountainViewModel.toggleIsPresenting()
                        navigationManager.popToRoot()
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
                
            }
        }
    }
    
    


//#Preview {
//    DueDateView(trackLocation: "", navigationManager: navigationmanag)
//}

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
    @State private var isDatePickerVisible: Bool = false
    
    @State private var showCustomAlert: Bool = false
    @State private var selectedHour: Int = 0
    let shortcutHours: [Int] = [1, 2, 4, 8, 12]
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Schedule")
                .font(.title1Emphasized)
                .foregroundStyle(Color.primaryGreen500)
            
            CustomLabelScheduleReminder(type: remainingTimeType, remainingTime: formattedRemainingTime)
                .padding(.bottom, 16)
            
            Text("Need more time?")
                .font(.subheadlineEmphasized)
                .foregroundStyle(Color.primaryGreen500)
                .padding(.bottom, 2)
            
            Text("You can add more time to extend your due at the basecamp")
                .font(.footnoteRegular)
                .foregroundStyle(Color.primaryGreen500)
                .padding(.bottom, 16)
            
            HStack(spacing: 8) {
                ForEach(shortcutHours, id: \.self) { hour in
                    Button(action: {
                        // Add the specified hours to the original `selectedDate`
                        //                        selectedDate = Calendar.current.date(byAdding: .hour, value: hour, to: selectedDate) ?? selectedDate
                        selectedHour = hour
                        showCustomAlert = true
                    }) {
                        shortCutView(for: hour)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .shadow(color: .black.opacity(0.08), radius: 7.92307, x: 0, y: 7.92307)
            .shadow(color: .black.opacity(0.04), radius: 1.98077, x: 0, y: 0)
            
            
            Button(action: {
                isDatePickerVisible.toggle()
            }) {
                arrivalDateView
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.top, 34)
            
            if isDatePickerVisible {
                DatePicker("", selection: $selectedDate, in: Date()..., displayedComponents: [.date, .hourAndMinute])
                    .datePickerStyle(WheelDatePickerStyle())
            }
            
            //            Button(action: {
            //                viewModel.dueDate = selectedDate
            //                Task {
            //                    await viewModel.updateDueDate()
            //                    navigationManager.popToRoot()
            //                }
            //            }) {
            //                Text("Save")
            //                    .frame(maxWidth: .infinity)
            //                    .padding()
            //                    .background(Color.blue)
            //                    .foregroundColor(.white)
            //                    .cornerRadius(8)
            //            }
            //            .padding()
            
            Spacer()
        }
        .navigationTitle("Edit Due Date")
        .padding(.horizontal, 25)
        .onAppear {
            selectedDate = viewModel.dueDate
        }
        .onDisappear {
            if selectedDate != viewModel.dueDate {
                viewModel.dueDate = selectedDate
                Task {
                    await viewModel.updateDueDate()
                }
            }
        }
        .overlay(
            showCustomAlert ? alertOverlay : nil
        )
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .topBarLeading){
                BackButtonComponent{
                    
                }
            }
        }
    }
}

// MARK: - Extension View
extension EditDueDateView {
    var arrivalDateView: some View {
        HStack {
            Text("Arrival Date")
                .font(.subheadlineRegular)
                .foregroundStyle(Color.primaryGreen500)
            
            Spacer()
            
            Text(dateFormatter.string(from: selectedDate))
                .font(.subheadlineRegular)
                .foregroundStyle(Color.primaryGreen500)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 20)
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.08), radius: 2, x: 0, y: 2)
        .shadow(color: .black.opacity(0.02), radius: 3, x: 0, y: 0)
    }
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "E d MMM HH:mm"
        return formatter
    }
    
    var remainingTimeInSeconds: TimeInterval {
        return max(0, selectedDate.timeIntervalSince(Date()))
    }
    
    var formattedRemainingTime: String {
        let hours = Int(remainingTimeInSeconds) / 3600
        let minutes = (Int(remainingTimeInSeconds) % 3600) / 60
        
        if hours > 0 {
            return "\(hours) hours"
        } else if minutes > 0 {
            return "\(minutes) minutes"
        } else {
            return "0 minutes"
        }
    }
    
    var remainingTimeType: CustomLabelScheduleReminder.ReminderType {
        let hoursRemaining = remainingTimeInSeconds / 3600
        
        switch hoursRemaining {
        case let x where x > 3:
            return .green
        case 1..<3:
            return .yellow
        case ...1:
            return .red
        default:
            return .red
        }
    }
    
    func shortCutView(for hour: Int) -> some View {
        VStack {
            Text("\(hour)")
                .font(.footnoteEmphasized)
                .foregroundStyle(Color.primaryGreen500)
            
            Text(hour == 1 ? "hr" : "hrs")
                .font(.footnoteEmphasized)
                .foregroundStyle(Color.primaryGreen500)
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(10)
        
    }
    
    var alertOverlay: some View{
        ZStack{
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
            
            CustomPopUpExtendTime(
                title: "Extend time by \(selectedHour) \(selectedHour == 1 ? "hour?" : "hours?")",
                onConfirm: {
                    selectedDate = Calendar.current.date(byAdding: .hour, value: selectedHour, to: selectedDate) ?? selectedDate
                    showCustomAlert = false
                },
                onCancel: {
                    showCustomAlert = false
                }
            )
           
        }
        .zIndex(1)
    }
    
}



#Preview {
    EditDueDateView(viewModel: EmergencyProsesViewModel())
        .environmentObject(NavigationManager())
}

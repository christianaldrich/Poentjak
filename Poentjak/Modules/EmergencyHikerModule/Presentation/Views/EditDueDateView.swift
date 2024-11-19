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
            
            HStack(spacing: 16) {
                ForEach(shortcutHours, id: \.self) { hour in
                    Button(action: {
                        selectedHour = hour
                        showCustomAlert = true
                    }) {
                        shortCutView(for: hour)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .customShadow()
            
            
            Button(action: {
                isDatePickerVisible.toggle()
            }) {
                arrivalDateView
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.top, 34)
            
            Spacer()
        }
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
        VStack(alignment: .center) {
            HStack {
                Text("Arrival Date")
                    .font(.subheadlineRegular)
                    .foregroundStyle(Color.primaryGreen500)
                
                Spacer()
                
                Text(formattedDateString)
                    .font(.subheadlineRegular)
                    .foregroundStyle(Color.primaryGreen500)
                    .padding(.horizontal, 8)
                
                Image(systemName: isDatePickerVisible ? "chevron.up" : "chevron.right")
                    .font(.bodyEmphasized)
                    .foregroundStyle(Color.primaryGreen500)
                
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 20)
            
            if isDatePickerVisible {
                Divider()
                    .frame(height: 1)
                    .background(Color.neutralGrayLightGray)
                    .padding(.horizontal, 16)
                
                DatePicker("", selection: $selectedDate, in: Date()..., displayedComponents: [.date, .hourAndMinute])
                    .datePickerStyle(WheelDatePickerStyle())
                    .padding(.top, 32)
                    .padding(.bottom, 54)
                    .padding(.trailing, 16)
                    
            }
        }
        .background(.white)
        .frame(maxWidth: .infinity, alignment: .center)
        .cornerRadius(16)
        .customShadow()
    }
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "E d MMM HH:mm"
        return formatter
    }

    var formattedDateString: String {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let selectedDay = calendar.startOfDay(for: selectedDate)

        if today == selectedDay {
            let formatter = DateFormatter()
            formatter.dateFormat = "'Today' HH:mm"
            return formatter.string(from: selectedDate)
        } else {
            return dateFormatter.string(from: selectedDate)
        }
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
            Text("+\(hour)")
                .font(.footnoteEmphasized)
                .foregroundStyle(Color.primaryGreen500)
            
            Text(hour == 1 ? "hr" : "hrs")
                .font(.footnoteEmphasized)
                .foregroundStyle(Color.primaryGreen500)
        }
        .padding(.horizontal, 16)
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

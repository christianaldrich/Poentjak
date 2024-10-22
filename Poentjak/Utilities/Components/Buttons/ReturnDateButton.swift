//
//  ReturnDateButton.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 22/10/24.
//

import SwiftUI

struct ReturnDateButton: View {
    var time: Date
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 340, height: 45)
                .foregroundStyle(Color.neutralWhite)
                .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2) // Add shadow
                .overlay {
                    HStack {
                        Image.AdminIcon.call
                        Text("Return by \(formatDate(time))") // Format time
                            .foregroundStyle(Color.primaryGreen500)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(Color.primaryGreen500)
                            .font(.system(size: 16, weight: .bold))
                    }
                    .padding(.horizontal, 16)
                }
        }
    }
    
    // Function to format the date to "HH:mm" format (e.g., 17:00)
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}

#Preview {
    ReturnDateButton(time: Date()) {
    }
}

//
//  DateFormatterRanger.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 19/10/24.
//

import Foundation

func formatDateToCustomString(date: Date) -> String {
    let formatter = DateFormatter()
    
    // Set the output format to match the desired string format
    formatter.dateFormat = "E, dd MMM HH.mm"
    
//    // Set the locale to ensure correct day and month names
//    formatter.locale = Locale(identifier: "en_US_POSIX")
    
    // Convert the Date object to a formatted string
    return formatter.string(from: date)
}

func minutesAgo(from date: Date) -> String {
    let now = Date()
    let diffComponents = Calendar.current.dateComponents([.minute], from: date, to: now)
    
    if let minutes = diffComponents.minute {
        if minutes > 1 {
            return "\(minutes) minutes ago"
        }
        else {
            return "Just now"
        }
    } else {
        return "Just now"
    }
}

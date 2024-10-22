//
//  DateFormatterRanger.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 19/10/24.
//

import Foundation

func formatDateToCustomString(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "E, dd MMM HH.mm"
    return formatter.string(from: date)
}

func minutesAgo(from date: Date) -> String {
    let now = Date()
    let diffComponents = Calendar.current.dateComponents([.minute], from: date, to: now)
    
    if let minutes = diffComponents.minute {
        if minutes > 1 {
            return "\(minutes) mins ago"
        }
        else {
            return "Just now"
        }
    } else {
        return "Just now"
    }
}

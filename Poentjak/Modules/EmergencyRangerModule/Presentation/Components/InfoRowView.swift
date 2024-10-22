//
//  InfoRowView.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 21/10/24.
//

import Foundation
import SwiftUI

struct InfoRowView: View {
    let title: String
    let value: String
    let emergencyRequest: EmergencyRequest
    
    var body: some View {
        HStack {
            Text("\(title) \(value)")
                .font(.footnoteRegular)
            Spacer()
            switch emergencyRequest.emergencyStatus {
            case .safe:
                CustomLabelRescueStatus(status: .new)
            case .danger:
                CustomLabelRescueStatus(status: .new)
            case .ongoing:
                CustomLabelRescueStatus(status: .ongoing)
            case .completed:
                CustomLabelRescueStatus(status: .complete)
            }
        }
    }
}


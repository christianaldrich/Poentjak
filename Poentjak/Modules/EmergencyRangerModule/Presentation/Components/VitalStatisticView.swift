//
//  VitalStatisticView.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 21/10/24.
//

import Foundation
import SwiftUI

struct VitalStatisticsView: View {
    let user: User
    
    var body: some View {
        HStack(spacing: 40) {
            vitalStatItem(label: "Age", value: "\(user.age)", unit: "years", icon: Image.LabelIcon.age)
            vitalStatItem(label: "Height", value: "\(Int(user.height))", unit: "cm", icon: Image.LabelIcon.height)
            vitalStatItem(label: "Weight", value: "\(Int(user.weight))", unit: "kg", icon: Image.LabelIcon.weight)
        }
        .padding(.horizontal, 8)
    }
    
    private func vitalStatItem(label: String, value: String, unit: String, icon: Image) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(label)
                    .font(.calloutRegular)
                Spacer()
                icon
            }
            HStack {
                Text(value)
                    .font(.title3Emphasized)
                Text(unit)
                    .font(.customPrimaryButton)
                Spacer()
            }
        }
    }
}

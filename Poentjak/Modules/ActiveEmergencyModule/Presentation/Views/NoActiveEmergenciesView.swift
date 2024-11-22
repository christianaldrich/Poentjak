//
//  NoActiveEmergenciesView.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 20/11/24.
//

import SwiftUI

struct NoActiveEmergenciesView: View {
    var body: some View {
        VStack(spacing: 32){
            Image.AdminIcon.noActiveEmergencies
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 101, height: 108)
            
            VStack(alignment: .center){
                Text("No active emergencies")
                Text("Great job!")
            }
            .font(.title2Emphasized)
            .foregroundStyle(Color.primaryGreen500)
        }
    }
}

#Preview {
    NoActiveEmergenciesView()
}

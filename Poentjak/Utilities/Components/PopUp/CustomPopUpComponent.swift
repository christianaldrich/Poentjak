//
//  CustomPopUpComponent.swift
//  Poentjak
//
//  Created by Shan Havilah on 29/10/24.
//

import SwiftUI

struct CustomPopUpComponent: View {
    var title: String
    var subtitle: String
    var message: String
    var imgName: String
    var closeAction: () -> Void = {}

    var body: some View {
        VStack {
            // Close button
            ZStack {
                HStack {
                    Button {
                        closeAction()
                    } label: {
                        Image.ButtonIcon.close
                            .renderingMode(.template) // This allows the icon to be tinted
                            .foregroundColor(Color.primaryGreen500)
                    }
                    .padding()
                    
                    Spacer()
                }
                
                // Title
                Text(title)
                    .font(.title2Emphasized)
                    .foregroundColor(Color.primaryGreen500)
                    .frame(maxWidth: .infinity) // This centers the title
            }
            .padding(.top, 4)
            .padding(.bottom, -4)

            VStack(alignment: .leading) {
                
                // Dark green rectangle placeholder
//                RoundedRectangle(cornerRadius: 16)
//                    .fill(Color.primaryGreen500)
//                    .frame(width: 303,height: 194)
                
                // Image with rounded corners
                Image(imgName) // Replace with your image name
                    .resizable()
                    .scaledToFill()
                    .frame(width: 303, height: 194)
                    .clipped()
                    .cornerRadius(16) // Apply the corner radius
                
                Text(subtitle)
                    .font(.title3Emphasized)
                    .foregroundColor(Color.primaryGreen500)
                    .padding(.top, 8)
                    .padding(.bottom, 4)
                
                Text(message)
                    .font(.subheadline)
                    .foregroundColor(Color.primaryGreen500)
                    //.padding(.top, 2)
            }
            .padding(.horizontal)
            .padding(.bottom, 15)
        }
        .background(Color.white)
        .cornerRadius(16)
        .frame(width: 340, height: 399)
        .customShadow()
    }
}

#Preview {
    CustomPopUpComponent(title: "Disclaimer!", subtitle: "Bring a powerbank", message: "For the best-app-usage, don't forget to bring a powerbank so you have enough battery to last your hike. 80% of your battery is lost when hiking down.", imgName: "dummy")
}


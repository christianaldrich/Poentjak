//
//  CustomCardGuideComponent.swift
//  Poentjak
//
//  Created by Felicia Himawan on 19/11/24.
//
import SwiftUI

struct CustomCardGuideComponent: View {
    var data: WiseGuideDataModel
    @State private var isNavigating = false  // State to trigger navigation
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(data.thumbnailImage)
                .resizable()
                .scaledToFill()
                .frame(width: 168, height: 212)
                .clipped()

            Text(data.title)
                .font(.footnoteEmphasizedBold)
                .foregroundColor(Color.neutralWhite)
                .padding(.vertical, 10)
                .padding(.horizontal, 10)
        }
        .frame(width: 168, height: 212)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 3)
        .onTapGesture {
            print("Card clicked")
            isNavigating = true  // Trigger the navigation
        }
        // The actual NavigationLink goes here and listens for the isNavigating state
//        .background(
//            NavigationLink(
//                destination: WiseGuideDetailView(data: data),
//                isActive: $isNavigating
//            ) {
//                EmptyView()  // Empty view so the link is hidden but still functional
//            }
//        )
    }
}

#Preview {
    NavigationStack {
        CustomCardGuideComponent(data: WiseGuideData.defaultData)
    }
}

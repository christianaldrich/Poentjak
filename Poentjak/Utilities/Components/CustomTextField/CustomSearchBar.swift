//
//  CustomSearchBar.swift
//  Poentjak
//
//  Created by Felicia Himawan on 21/10/24.
//

import SwiftUI

struct CustomSearchBar: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image.PickerIcon.search
                .renderingMode(.template)
                .foregroundStyle(Color.neutralGrayTertiaryGray)

            TextField("Search here", text: $searchText)
                .padding(10)
                .foregroundColor(searchText.isEmpty ? Color.neutralGrayTertiaryGray : Color.primaryGreen500)
                .font(.subheadlineRegular)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 14)
        .frame(width: 302)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.08), radius: 2, x: 0, y: 2)
        .shadow(color: .black.opacity(0.02), radius: 3, x: 0, y: 0)
    }
}

struct CustomSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomSearchBar(searchText: .constant("fefe"))
    }
}

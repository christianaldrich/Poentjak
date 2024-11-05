//
//  SearchBarComponent.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 04/11/24.
//

import SwiftUI

struct SearchBarComponent: View {
    @Binding var text: String // The search text binding
    var placeholder: String = "Search" // Default placeholder text
    

    
    var body: some View {
        HStack {
            // Search icon
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            // Text field for search input
            TextField(placeholder, text: $text)
                .foregroundColor(.primary)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            // Clear button
            if !text.isEmpty {
                Button(action: {
                    text = "" // Clear the search text
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(10)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

//#Preview {
//    SearchBarComponent()
//}

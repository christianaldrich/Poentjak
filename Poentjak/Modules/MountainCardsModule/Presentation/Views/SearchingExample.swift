//
//  SearchingExample.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 04/11/24.
//

import SwiftUI

struct SearchingExample: View {
    
    @State private var text = ""
    
    var body: some View {
        NavigationView{
            SearchedView()
//            Text(isSearching ? "Searching!" : "Not searching.")
                .searchable(text: $text)
        }
    }
}

#Preview {
    SearchingExample()
}

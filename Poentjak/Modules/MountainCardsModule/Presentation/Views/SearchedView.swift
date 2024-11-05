//
//  EmptyTaskView.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 16/10/24.
//

import SwiftUI

struct SearchedView: View {
    @Environment(\.isSearching) private var isSearching

    var body: some View {
        Text(isSearching ? "Searching!" : "Not searching.")
            .onChange(of: isSearching){
                print("ASDFASDF")
            }
    }
}

//#Preview {
//    SearchedView()
//}

//
//  EmptyTaskView.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 16/10/24.
//

import SwiftUI

struct EmptyTaskView: View {
    @EnvironmentObject var viewModel : MountainsTracksViewModel
    
    var body: some View {
        Text("Hello, World!")
//        Button("AN JING LA U"){
////            viewModel.isPresenting = false
//
//        }
    }
}

#Preview {
    EmptyTaskView()
}

//
//  NextTempView.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 29/10/24.
//

import SwiftUI

struct UploadTesting: View {
    @StateObject var viewModel: AuthViewModel

    var body: some View {
        Text("Next View ")
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    BackButtonComponent{
                        viewModel.currentIndex = (viewModel.currentIndex) - 1
                    }
                }
            }
    }
}

//#Preview {
//    NextTempView(viewModel: AuthViewModel)
//}

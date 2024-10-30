//
//  NextTempView.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 29/10/24.
//

import SwiftUI

struct NextTempView: View {
    @StateObject var viewModel: HikerRegisViewModel

    var body: some View {
        Text("Next View ")
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    BackButtonComponent{
                        viewModel.currentIndex = (viewModel.currentIndex ?? 0) - 1
                    }
                }
            }
    }
}

#Preview {
    NextTempView(viewModel: HikerRegisViewModel())
}

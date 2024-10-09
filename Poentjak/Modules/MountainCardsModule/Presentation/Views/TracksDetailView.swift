//
//  TracksDetailView.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 08/10/24.
//

import SwiftUI

struct TracksDetailView: View {
    let track: String
    
    var body: some View {
        VStack{
//            Text("Name: \(track)")
            Text("\(track)")
            NavigationLink{
                DueDateView()
            }label: {
                Text("Start Tracking")
            }
        }
    }
}

//#Preview {
//    TracksDetailView()
//}

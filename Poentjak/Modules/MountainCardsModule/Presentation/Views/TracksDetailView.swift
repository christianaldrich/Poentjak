//
//  TracksDetailView.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 08/10/24.
//

import SwiftUI

struct TracksDetailView: View {
    let track: String
    @State private var navigateToDueDate = false
    @ObservedObject var navigationManager : MountainNavigationManager
    
    var body: some View {
        VStack{
//            Text("Name: \(track)")
            Text("\(track)")
            
//            Button(action: {
//                navigateToDueDate = true
//            }) {
//                Text("Start Tracking")
//                    .font(.headline)
//                    .padding()
//                    .background(Color.green)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//            .padding(.top)
            Button("Start Tracking"){
                navigationManager.navigationPath.append(MountainDestinationView.dueDate(trackLocation: track))
                
            }
            
//            NavigationLink{
//                DueDateView(trackLocation: track)
//            }label: {
//                Text("Start Tracking")
//            }
//           
        }
//        .navigationDestination(isPresented: $navigateToDueDate){
//            DueDateView()
//        }
        
       
    }
}

//#Preview {
//    TracksDetailView()
//}

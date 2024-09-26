//
//  ContentView.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 23/09/24.
//

import SwiftUI

struct ContentView: View {
//    @StateObject var viewModel = UserViewModel(useCase: DefaultFetchUsersUseCase(repository: DefaultUserRepository(dataSource: FirebaseDatabaseDS() as! UserRepository)))
    @StateObject var viewModel = UserViewModel()
    var body: some View {
        VStack {
//            Button("Press"){
//                RangerConfirmation().addData()
//            }
            
            Text("Hello")
        }
        .padding()
        .onAppear{
//            FetchData().fetchUsers()
            Task{
                viewModel.getUsers()
            }
        }
    }
}

#Preview {
    ContentView()
}

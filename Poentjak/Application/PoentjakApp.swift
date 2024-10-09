//
//  PoentjakApp.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 23/09/24.
//

import SwiftUI
import Firebase

@main
struct PoentjakApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    private let diContainer = DIContainer()

    
//    init(){
//        FirebaseApp.configure()
//        print("Configured Firebase!")
//    }
    
    var body: some Scene {
        WindowGroup {

            let authViewModel = diContainer.makeAuthViewModel()
            CheckingView(viewModel: authViewModel)
//            RangerView()

//            let authViewModel = diContainer.makeAuthViewModel()
//            CheckingView(viewModel: authViewModel)
//            RangerView()
//            ActiveHikersView()
            // MountainsTracksView()

        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        print("Configured Firebase!")
        return true
    }
}

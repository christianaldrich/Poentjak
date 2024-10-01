//
//  RangerListComponent.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 01/10/24.
//

import SwiftUI
import Foundation

struct RangerListViewComponent: View {
    @StateObject private var viewModel = UserViewModel()
    @State private var activeEmergencies = [UserModel]()
    
    @State var selectedUser: UserModel?
    @State private var isDetailViewActive = false
    
    
    var body: some View {
        
    }
}

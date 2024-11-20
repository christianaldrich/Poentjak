//
//  NotifView.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 19/11/24.
//

import SwiftUI
import UserNotifications

struct NotifView: View {
    var body: some View {
        VStack{
            Button("Request Permission"){
                NotificationManager.instance.requestAuth()
            }
//            Button("Schedule Notif"){
//                NotificationManager.instance.schedu()
//            }
        }
    }
}

#Preview {
    NotifView()
}

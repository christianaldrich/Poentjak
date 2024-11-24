//
//  RangerPushNotification.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 19/11/24.
//

import Foundation
import UserNotifications

class NotificationManager{
    static let instance = NotificationManager()
    
    func requestAuth(){
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options){ (success, error) in
            if let error = error {
                print("Error: \(error)")
            }else{
                print("Permission granted")
            }
            
        }
    }
    
    func scheduleNotification(title: String, subtitle: String? = nil, body: String? = nil, delay: TimeInterval = 1.0) {
            let content = UNMutableNotificationContent()
            content.title = title
            if let subtitle = subtitle {
                content.subtitle = subtitle
            }
            if let body = body {
                content.body = body
            }
            content.sound = .default
            content.badge = 1
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: delay, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error)")
                } else {
                    print("Notification scheduled successfully")
                }
            }
        }
    
//    func scheduleNotif(){
//        let content = UNMutableNotificationContent()
//        content.title = "Notif"
//        content.subtitle = "Gampang banget!"
//        
//        content.sound = .default
//        content.badge = 1
//        
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
//        
//        let request = UNNotificationRequest(identifier: UUID().uuidString
//                                            , content: content
//                                            , trigger: trigger)
//        
//        UNUserNotificationCenter.current().add(request)
//        
//    }

    
}

//
//  LocalNotificationsController.swift
//  Financies
//
//  Created by Juan on 1/9/20.
//  Copyright © 2020 Juan. All rights reserved.
//

import Foundation
import UserNotifications

class LocalNotificationsController {
    init() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (success, error) in
            if success {
                self.addNotifications()
            }
        }
    }
    
    func addNotifications() {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        
        content.title = "Have you bought anything today?"
        content.body = "Remember to add your expenses on Transactions!"
        content.sound = UNNotificationSound.default
        
        /*let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 10.0,
            repeats: false
        )*/
        
        var dateComponents = DateComponents()
        
        dateComponents.calendar = Calendar.current
        
        dateComponents.weekday = dateComponents.day//4  // Wednesday
        dateComponents.hour = 20// 20:00 hours
        dateComponents.minute = 00// 20:00 minutes
        dateComponents.second = 00// 20:00:00 seconds
        
        dateComponents.timeZone = .current
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: true
        )
        
        let request = UNNotificationRequest(
            identifier: "inteenseconds",
            content: content,
            trigger: trigger
        )
        
        center.add(request) { (error) in
            guard let error = error else { return }
            
            print(error.localizedDescription)
        }
    }
}

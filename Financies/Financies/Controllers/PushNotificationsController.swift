//
//  PushNotificationsController.swift
//  Financies
//
//  Created by Juan on 1/9/20.
//  Copyright © 2020 Juan. All rights reserved.
//

import UIKit
import FirebaseMessaging
import UserNotifications

class PushNotificationsController: NSObject {
    init(application: UIApplication) {
        super.init()
        
        UNUserNotificationCenter.current().requestAuthorization(
        options: [.alert, .badge, .sound]) { (success, error) in
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
        }
        
        Messaging.messaging().delegate = self
    }
    
    func addDeviceToken(_ token: Data) {
        Messaging.messaging().apnsToken = token
    }
}

extension PushNotificationsController: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registring token \(fcmToken)")
        
        let data: [String: String] = ["token": fcmToken]
        
    }
}

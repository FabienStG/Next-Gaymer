//
//  AppDelegate.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 06/02/2022.
//

import Foundation
import GoogleSignIn
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate {
  
  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    return GIDSignIn.sharedInstance.handle(url)
  }
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    registerForNotification()
    //configureUserNotification()
    return true
  }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
  
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler(.banner)
  }
  
  func registerForNotification() {
    
    UNUserNotificationCenter.current()
      .requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
      }
  }
  
  /*private func configureUserNotification() {
    UNUserNotificationCenter.current().delegate = self
    
    let dissmissAction = UNNotificationAction(
      identifier: "dissmiss",
      title: "Dismiss",
      options: [])

    let category = UNNotificationCategory(
      identifier: "NextGaymerCategory",
      actions: [dissmissAction],
      intentIdentifiers: [], options: [])
    
    UNUserNotificationCenter.current()
      .setNotificationCategories([category])
  }
  
  /*func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
   
   if response.actionIdentifier == "remove" {
   let userInfo = response.notification.request.content.userInfo
   if let reminderData = userInfo["Reminder"] as? Data {
   if let reminder = try? JSONDecoder.decode(Reminder.self,
   from: reminderData) {
   ReminderManager.shared.remove(reminder: reminder
   }
   }
   }
   completionHandler()
   }*/*/
  
}

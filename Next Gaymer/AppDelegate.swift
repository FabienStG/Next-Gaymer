//
//  AppDelegate.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 06/02/2022.
//

import Foundation
import GoogleSignIn
import UserNotifications
//
// MARK: - App Delegate
//

/// Even if swiftUI do not provide an AppDelegate anymore, it still needed for several function so this is a custom one
class AppDelegate: NSObject, UIApplicationDelegate {
  //
  // MARK: - Internal Methods
  //
  /// This is for allow the Google SignIn button to open a specific URL when needed
  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    return GIDSignIn.sharedInstance.handle(url)
  }
  
  /// This manage the notifications options when the app launch
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    registerForNotification()
    //configureUserNotification()
    return true
  }
}

//
// MARK: - Extension App Delegate - Notification Center Delegate
//

/// This extension provide the necessary function to allow the local notifications
extension AppDelegate: UNUserNotificationCenterDelegate {
  //
  // MARK: - Internal Methods
  //
  /// This function manage the notification when the app is not open
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification,
                              withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler(.banner)
  }
  
  /// This is the ask user function to allowed or not the notifications
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

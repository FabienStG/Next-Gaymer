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
    managerInitialization()
    registerForNotification()
    return true
  }
  
  private func managerInitialization() {
    DataManager.initialized(registrationServices: FirebaseRegistrationServices(), chatServices: FirebaseChatServices(),
                            eventServices: FirebaseEventServices(), adminServices: FirebaseAdminService(),
                            userServices: FirebaseUserServices(), centerServices: FirebaseCenterServices())
    
    NotificationManager.initialized(notificationsServices: UserNotificationServices())
    
    MapManager.initialized(mapServices: MapKitServices())
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
}

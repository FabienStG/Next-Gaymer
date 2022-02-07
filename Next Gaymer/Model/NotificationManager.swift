//
//  NotificationManager.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 06/02/2022.
//

import Foundation
//
// MARK: - Notification Manager
//

/// This class use the notification service and provide his function for the view models
class NotificationManager {
  //
  // MARK: - Singleton
  //
  static let shared = NotificationManager()
  
  private init() {}
  //
  // MARK: - Private Constant
  //
  private let notificationSercices = NotificationServices()
  
  //
  // MARK: - Internal Methods
  //
  /// Call the notifications services to schedule a notification and add the choice into firestore
  func addNotification(event: EventCreated) {
    
    notificationSercices.scheduleNotification(event: event)
    notificationSercices.setNotificationPreference(event: event, preference: true)
  }
  
  /// Remove the notification and update the user preference in firestore
  func removeNotification(event: EventCreated) {
    
    notificationSercices.removeScheduleNotification(event: event)
    notificationSercices.setNotificationPreference(event: event, preference: false)
  }
  
  /// Fetch the document saved into firestore to know the preview user preference about the event reminder's status
  func fetchNotificationStatus(event: EventCreated, completionHandler: @escaping(Bool) -> Void) {
    notificationSercices.fetchReminderPreference(event: event) { result in
      return completionHandler(result)
    }
  }
}

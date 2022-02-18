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
  static var _shared: NotificationManager?

  //
  // MARK: - Private Constant
  //
  private let notificationServices: NotificationsServices
  
  init(notificationsServices: NotificationsServices) {
    
    self.notificationServices = notificationsServices
  }
  
  static func initialized(notificationsServices: NotificationsServices) {
    
    _shared = NotificationManager(notificationsServices: notificationsServices)
  }
  
  static func shared() -> NotificationManager {
    
    return _shared!
  }
  
  //
  // MARK: - Internal Methods
  //
  /// Call the notifications services to schedule a notification and add the choice into firestore
  func addNotification(event: EventCreated) {
    
    notificationServices.scheduleNotification(event: event)
    notificationServices.setNotificationPreference(event: event, preference: true)
  }
  
  /// Remove the notification and update the user preference in firestore
  func removeNotification(event: EventCreated) {
    
    notificationServices.removeScheduleNotification(event: event)
    notificationServices.setNotificationPreference(event: event, preference: false)
  }
  
  /// Fetch the document saved into firestore to know the preview user preference about the event reminder's status
  func fetchNotificationStatus(event: EventCreated, completionHandler: @escaping(Bool) -> Void) {
    notificationServices.fetchReminderPreference(event: event) { result in
      return completionHandler(result)
    }
  }
}

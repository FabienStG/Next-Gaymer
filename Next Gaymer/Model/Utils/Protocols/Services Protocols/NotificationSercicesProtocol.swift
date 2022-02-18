//
//  NotificationSercicesProtocol.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 15/02/2022.
//

import Foundation

protocol NotificationsServices {
  
  /// This remove the scheduled notification
  func removeScheduleNotification(event: EventCreated)
  
  /// This fetch the selected event from current user, and return the reminder preference
  func fetchReminderPreference(event: EventCreated, completionHandler: @escaping(Bool) -> Void)
  
  /// Update the notification preference saved in firestore
  func setNotificationPreference(event: EventCreated, preference: Bool)

  /// This function take the event's date, and make a notification with it
  func scheduleNotification(event: EventCreated)
}

//
//  NotificationManager.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 06/02/2022.
//

import Foundation
import Firebase
import UserNotifications
//
// MARK: - Notifications Services
//

/// This class manage the local notifications and the saved preferences of it in firestore
class NotificationServices {
  //
  // MARK: - Private Constants
  private let db = Firestore.firestore()
  private let auth = Auth.auth()
  
  //
  // MARK: - Internal Methods
  //
  /// It retrieve the scheluded notifications thanks to the event id and remove it
  func removeScheduleNotification(event: EventCreated) {
    
    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [event.id])
  }
  
  /// This fetch the selected event from current user, and return the reminder preference
  func fetchReminderPreference(event: EventCreated, completionHandler: @escaping(Bool) -> Void) {
    
    guard let userId = auth.currentUser?.uid else { return }
    db.collection(EventConstant.eventReminder).document(userId).collection(userId).document(event.id).getDocument { document, error in
      if let response = document?.data() {
        if let status = response["reminderIsActive"] as? Bool {
          return completionHandler(status)
        }
      }
    }
  }
  
  /// Update the notification preference saved in firestore
  func setNotificationPreference(event: EventCreated, preference: Bool) {
    
    guard let userId = auth.currentUser?.uid else { return }
    
    db.collection(EventConstant.eventReminder).document(userId).collection(userId).document(event.id).updateData(
      [EventConstant.reminderIsActive: preference])
  }

  /// This function take the event's date, and make a notification with it
  func scheduleNotification(event: EventCreated) {
    
    let content = UNMutableNotificationContent()
    content.title = event.eventName
    content.body = NSLocalizedString("notificationBody", comment: "")
    
    let trigger = UNCalendarNotificationTrigger(
      dateMatching: Calendar.current.dateComponents(
        [.day, .month, .year, .hour, .minute] ,from: event.date),
      repeats: false)
    
    let request = UNNotificationRequest(identifier: event.id, content: content, trigger: trigger)
    
    UNUserNotificationCenter.current().add(request) { error in
      if let error = error {
        print(error)
      }
    }
  }
}

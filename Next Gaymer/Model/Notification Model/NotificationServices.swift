//
//  NotificationManager.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 06/02/2022.
//

import Foundation
import UserNotifications

class NotificationServices {
    
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
  
  func removeScheduleNotification(event: EventCreated) {
    
    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [event.id])
  }
}

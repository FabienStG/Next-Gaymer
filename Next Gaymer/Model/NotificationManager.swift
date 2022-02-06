//
//  NotificationManager.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 06/02/2022.
//

import Foundation

class NotificationManager {
  
  static let shared = NotificationManager()
  
  private init() {}
  
  private let notificationSercices = NotificationServices()
  
  func addNotification(event: EventCreated) {
    
    notificationSercices.scheduleNotification(event: event)
  }
  
  func removeNotification(event: EventCreated) {
    
    notificationSercices.removeScheduleNotification(event: event)
  }
}

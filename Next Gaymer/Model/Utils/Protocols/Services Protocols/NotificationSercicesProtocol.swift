//
//  NotificationSercicesProtocol.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 15/02/2022.
//

import Foundation
//
// MARK: - Notification Services Protocol
//

/// This protocol help for the firebase and local notifications mocking tests
protocol NotificationsServices {

  func removeScheduleNotification(event: EventCreated)
  
  func fetchReminderPreference(event: EventCreated, completionHandler: @escaping(Bool) -> Void)
  
  func setNotificationPreference(event: EventCreated, preference: Bool)

  func scheduleNotification(event: EventCreated)
}

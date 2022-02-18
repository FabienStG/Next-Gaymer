//
//  MockedNotificationsServices.swift
//  Next GaymerTests
//
//  Created by Fabien Saint Germain on 16/02/2022.
//

import Foundation
@testable import Next_Gaymer

class MockedNotificationsServices:  NotificationsServices {
  
  var didFunctionRemoveCalled = false
  var didFunctionSetCalled = false
  var didFunctionScheduleCalled = false
  
  func removeScheduleNotification(event: EventCreated) {
    didFunctionRemoveCalled = true
  }
  
  func fetchReminderPreference(event: EventCreated, completionHandler: @escaping (Bool) -> Void) {
    return completionHandler(true)
  }
  
  func setNotificationPreference(event: EventCreated, preference: Bool) {
    didFunctionSetCalled = true
  }
  
  func scheduleNotification(event: EventCreated) {
    didFunctionScheduleCalled = true
  }
}

class MockedNotificationsServicesFailed:  NotificationsServices {
  
  func removeScheduleNotification(event: EventCreated) {}
  
  func fetchReminderPreference(event: EventCreated, completionHandler: @escaping (Bool) -> Void) {
    return completionHandler(false)
  }
  
  func setNotificationPreference(event: EventCreated, preference: Bool) {}
  
  func scheduleNotification(event: EventCreated) {}
}

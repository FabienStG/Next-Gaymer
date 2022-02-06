//
//  MyEventDetailViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 04/02/2022.
//

import SwiftUI

class MyEventDetailViewModel: ObservableObject {
  
  @Published var selectedEvent: EventCreated
  @Published var message = ""
  @Published var showAlert = false
  @Published var requestStatus: RequestStatus = .initial
  @Published var isReminderActive = false
  
  init(selectedEvent: EventCreated) {
    self.selectedEvent = selectedEvent
  }
  
  func removeUserFromEvent(currentUser: UserRegistered) {
    requestStatus = .processing
    DataManager.shared.deleteUserFromEvent(currentUser: currentUser, event: selectedEvent) { result, message in
      if !result {
        self.requestStatus = .fail
      } else {
        NotificationManager.shared.removeNotification(event: self.selectedEvent)
        self.requestStatus = .success
      }
      self.message = message
      self.showAlert.toggle()
    }
  }
  
  func manageReminder() {
    if !isReminderActive {
      NotificationManager.shared.addNotification(event: selectedEvent)
      self.isReminderActive.toggle()
    } else if isReminderActive {
      NotificationManager.shared.removeNotification(event: selectedEvent)
      self.isReminderActive.toggle()
    }
  }
}

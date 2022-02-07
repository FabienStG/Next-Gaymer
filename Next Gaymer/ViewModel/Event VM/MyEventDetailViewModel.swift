//
//  MyEventDetailViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 04/02/2022.
//

import SwiftUI
//
// MARK: - My EventDetails VM
//

/// This class show the selected event information and manage the notifications
class MyEventDetailViewModel: ObservableObject {
  //
  // MARK: - Published Var
  //
  @Published var selectedEvent: EventCreated
  @Published var isReminderActive = false
  
  @Published var message = ""
  @Published var showAlert = false
  @Published var requestStatus: RequestStatus = .initial

  //
  // MARK: - Initialization
  //
  init(selectedEvent: EventCreated) {
    self.selectedEvent = selectedEvent
    fetchReminderStatus()
  }
  
  //
  // MARK: - Internal Methods
  //
  /// This function add or remove notifications dependly on the user choice
  func manageReminder() {
    if !isReminderActive {
      isReminderActive.toggle()
      NotificationManager.shared.addNotification(event: selectedEvent)
    } else if isReminderActive {
      isReminderActive.toggle()
      NotificationManager.shared.removeNotification(event: selectedEvent)
    }
  }
  
  /// This function remove the user from the registrate event list
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
  
  //
  // MARK: - Private Method
  //
  /// This function check the reminder status register from firebase
  private func fetchReminderStatus() {
    NotificationManager.shared.fetchNotificationStatus(event: selectedEvent) { result in
      self.isReminderActive = result
    }
  }
}

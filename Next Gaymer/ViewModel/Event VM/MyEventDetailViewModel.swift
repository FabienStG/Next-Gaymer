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
  
  init(selectedEvent: EventCreated) {
    self.selectedEvent = selectedEvent
  }
  
  func removeUserFromEvent(currentUser: UserRegistered) {
    requestStatus = .processing
    DataManager.shared.deleteUserFromEvent(currentUser: currentUser, event: selectedEvent) { result, message in
      if !result {
        self.requestStatus = .fail
      } else {
        self.requestStatus = .success
      }
      self.message = message
      self.showAlert.toggle()
    }
  }
}

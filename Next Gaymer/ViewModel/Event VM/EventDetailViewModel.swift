//
//  EventDetailViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 02/02/2022.
//

import SwiftUI

//
// MARK: - Event Detail VM
//

/// This class is used to registrate the selected event and registrate the user
class EventDetailViewModel: ObservableObject {
  //
  // MARK: - Published Properties
  //
  @Published var alertMessage = ""
  @Published var showAlert = false
  @Published var event: EventCreated
  @Published var disableButton = false
  @Published var requestStatus: RequestStatus = .initial
  @Published var showRegistrants = false
  
  //
  // MARK: - Initialization
  //
  init(event: EventCreated) {
    self.event = event
  }
  
  //
  // MARK: - Internal Method
  //
  func registrateUserToEvent(currentUser: UserRegistered, event: EventCreated) {
    self.requestStatus = .processing
    DataManager.shared.registrateUserForEvent(currentUser: currentUser, event: event) { result, message in
      if result {
        self.disableButton = true
        self.requestStatus = .success
      }
      self.alertMessage = message
      self.showAlert.toggle()
      self.requestStatus = .fail
    }
  }
}

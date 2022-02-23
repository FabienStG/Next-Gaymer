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

/// This class is used to registrate the selected event and registrate the user. It manage also the sheet view
class EventDetailViewModel: ObservableObject {
  //
  // MARK: - Published Properties
  //
  @Published var event: EventCreated
  @Published var showRegistrants = false
  @Published var showOptions = false
  
  @Published var alertMessage = ""
  @Published var showAlert = false

  @Published var disableButton = false
  @Published var requestStatus: RequestStatus = .initial

  
  //
  // MARK: - Initialization
  //
  init(event: EventCreated) {
    self.event = event
  }
  
  //
  // MARK: - Internal Method
  //
  /// This registrate the user in the selected event and show an alert depending of the manager response
  func registrateUserToEvent(currentUser: UserRegistered) {
    self.requestStatus = .processing
    DataManager.shared().registrateUserForEvent(currentUser: currentUser, event: event) { result, message in
      if result {
        self.disableButton = true
        self.requestStatus = .success
      } else if !result {
        self.requestStatus = .fail
      }
      self.alertMessage = message
      self.showAlert.toggle()
    }
  }
}

//
//  EventDetailViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 02/02/2022.
//

import SwiftUI

class EventDetailViewModel: ObservableObject {
  
  @Published var alertMessage = ""
  @Published var showAlert = false
  
  func registrateUserToEvent(currentUser: UserRegistered, event: EventCreated) {
    DataManager.shared.registrateUserForEvent(currentUser: currentUser, event: event) { result, message in
      self.alertMessage = message
      self.showAlert.toggle()
    }
  }
  
}

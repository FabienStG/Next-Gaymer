//
//  RegistrantListAdminViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 05/02/2022.
//

import SwiftUI
//
// MARK: - RegistrantList Admin VM
//

/// This class provide to the view the list of the users registered in an event
class RegistrantListAdminViewModel: ObservableObject {
  //
  // MARK: - Published Properties
  //
  @Published var registrantList = [UserDetails]()
  @Published var confirmed = false
  
  @Published var errorMessage = ""
  @Published var showAlert = false

  //
  // MARK: - Internal Method
  //
  /// This function fetch the list of user registered on the event and return for the view
  func fetchRegistrantList(event: EventCreated) {
    
    DataManager.shared().fetchUserRegisterToEvent(event: event) { userList in
      self.registrantList = userList
    } errorHandler: { error in
      self.errorMessage = error
      self.showAlert.toggle()
    }
  }
}


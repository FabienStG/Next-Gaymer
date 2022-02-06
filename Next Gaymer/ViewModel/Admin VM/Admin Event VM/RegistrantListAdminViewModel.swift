//
//  RegistrantListAdminViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 05/02/2022.
//

import SwiftUI

class RegistrantListAdminViewModel: ObservableObject {
  
  @Published var registrantList = [UserDetails]()
  @Published var errorMessage = ""
  @Published var showAlert = false
  @Published var confirmed = false
 
  func fetchRegistrantList(event: EventCreated) {
    
    DataManager.shared.fetchUserRegisterToEvent(event: event) { userList in
      self.registrantList = userList
    } errorHandler: { error in
      self.errorMessage = error
      self.showAlert.toggle()
    }
  }
}

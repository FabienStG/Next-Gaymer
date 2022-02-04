//
//  MyEventViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 04/02/2022.
//

import SwiftUI

class MyEventViewModel: ObservableObject {
  
  @Published var myEventList = [EventCreated]()
  @Published var errorMessage = ""
  @Published var showAlert = false
  
  
  func fetchMyEventList(currentUser: UserRegistered) {
    DataManager.shared.fetchMyEvent(currentUser: currentUser) { eventList, error in
      if eventList.isEmpty && error != nil {
        self.errorMessage = error!
        self.showAlert.toggle()
      }
      self.myEventList = eventList
    }
  }
}

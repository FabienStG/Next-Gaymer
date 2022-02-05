//
//  MyEventListViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 04/02/2022.
//

import SwiftUI

class MyEventListViewModel: ObservableObject {
  
  @Published var myEventList = [EventCreated]()
  @Published var errorMessage = ""
  @Published var showAlert = false
  
  init() {
    updateEvent()
  }
  
  func updateEvent() {
    DataManager.shared.fetchMyEvents { myEventList, error in
      self.myEventList = myEventList
      if let error = error {
        self.errorMessage = error
        self.showAlert.toggle()
      }
    }
  }
}

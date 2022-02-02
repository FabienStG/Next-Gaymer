//
//  EventListViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 30/01/2022.
//

import SwiftUI

class EventListViewModel: ObservableObject {
  
  @Published var eventList = [EventCreated]()
  
  @Published var errorMessage = ""
  @Published var showAlert =  false
  
  init() {
    fetchEventList()
  }
  
  func fetchEventList() {
    DataManager.shared.fetchAllEvents { allEvent, error in
      if let allEvent = allEvent {
        self.eventList = allEvent
      } else {
        self.errorMessage = error!
        self.showAlert.toggle()
      }
    }
  }
  
}


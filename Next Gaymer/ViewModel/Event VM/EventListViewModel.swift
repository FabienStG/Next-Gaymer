//
//  EventListViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 30/01/2022.
//

import SwiftUI

class EventListViewModel: ObservableObject {
  
  @Published var eventList = [EventCreated]()
  
  init() {
    fetchEventList()
  }
  
  func fetchEventList() {
    DataManager.shared.fetchAllEvents { allEvent, error in
      if let allEvent = allEvent {
        self.eventList = allEvent
      } else {
        print(error ?? "Failed to fetch list")
      }
    }
  }
  
}


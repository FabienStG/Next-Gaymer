//
//  EventListViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 30/01/2022.
//

import SwiftUI

//
// MARK: - EventList VM
//

/// This class fetch the event list and provide it to the view
class EventListViewModel: ObservableObject {
  //
  // MARK: - Published Properties
  //
  @Published var eventList = [EventCreated]()
  @Published var errorMessage = ""
  @Published var showAlert =  false
  
  //
  // MARK: - Initialization
  //
  init() {
    fetchEventList()
  }
  
  //
  // MARK: - Internal Method
  //
  /// Fetch all the events to show them in the view
  func fetchEventList() {
    DataManager.shared().fetchAllEvents { allEvent, error in
      if let allEvent = allEvent {
        self.eventList = allEvent
      } else {
        self.errorMessage = error!
        self.showAlert.toggle()
      }
    }
  }
}


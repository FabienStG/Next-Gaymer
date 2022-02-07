//
//  MyEventListViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 04/02/2022.
//

import SwiftUI
//
// MARK: - My EventList VM
//

/// This VM provide to the view the event who the current user is registrate in
class MyEventListViewModel: ObservableObject {
  //
  // MARK: - Published Properties
  //
  @Published var myEventList = [EventCreated]()
  @Published var errorMessage = ""
  @Published var showAlert = false
  
  //
  // MARK: - Initialization
  //
  init() {
    updateEvent()
  }
  
  //
  // MARK: - Internal Method
  //
  /// This function update the event list by fetching the last version on the document in firestore 
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

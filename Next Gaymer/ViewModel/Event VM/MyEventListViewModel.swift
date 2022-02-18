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
class MyEventListViewModel: EventListViewModel {
  //
  // MARK: - Override Method
  //
  /// This function update the event list by fetching the last version on the document in firestore 
  override func fetchEventList() {
    DataManager.shared().fetchMyEvents { myEventList, error in
      self.eventList = myEventList
      if let error = error {
        self.errorMessage = error
        self.showAlert.toggle()
      }
    }
  }
}

//
//  EventRegisterAdminViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 30/01/2022.
//

import SwiftUI
//
// MARK: - Event Register Admin VM
//

/// This class provide to the event creation view admin all the info for the text fields and the form and save it into firebase
class EventRegisterAdminViewModel: ObservableObject {
  //
  // MARK: - Published Properties
  //
  @Published var image = UIImage()
  @Published var eventName = ""
  @Published var isOffline = true
  @Published var date = Date()
  @Published var location = ""
  @Published var town = ""
  @Published var madeBy = ""
  @Published var description = ""
  @Published var maximumPlaces: CGFloat = 0
  
  @Published var alertMessage = ""
  @Published var showAlert = false
  @Published var showConfirmation = false
  
  @Published var changeBannerImage = false
  @Published var openCameraRoll = false
  
  @Published var requestStatus: RequestStatus = .initial
  
  //
  // MARK: - Internal Method
  //
  /// This function save the data provide by the user as an event in firestore
  func registrateEvent() {
    self.requestStatus = .processing
    
    DataManager.shared.createEvent(
      event: packEventForm(),
      image: image) { result, error in
      if !result {
        self.alertMessage = error ?? NSLocalizedString("failCreateEvent", comment: "")
        self.showAlert.toggle()
        self.requestStatus = .fail
      } else if result {
        self.requestStatus = .success
      }
    }
  }
  
  //
  // MARK: - Private Method
  //
  /// Turn all the published properties provide by the user and create the object
  private func packEventForm() -> EventForm {
    let event = EventForm(eventName: eventName, isOffline: isOffline, date: date,
                          location: location, town: town, madeBy: madeBy,
                          description: description, maximumPlaces: Int(maximumPlaces))
    
    return event
  }
}

//
//  EventRegisterAdminViewModel.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 30/01/2022.
//

import SwiftUI

class EventRegisterAdminViewModel: ObservableObject {
  
  @Published var image = UIImage()
  @Published var eventName = ""
  @Published var isOffline = true
  @Published var date = Date()
  @Published var startHour = Date()
  @Published var endHour = Date()
  @Published var location = ""
  @Published var madeBy = ""
  @Published var shortDescription = ""
  @Published var longDescription = ""
  @Published var maximumPlaces = 0
  
  @Published var alertMessage = ""
  @Published var showAlert = false
  
  @Published var changeBannerImage = false
  @Published var openCameraRoll = false
  
  func registrateEvent() {
    
    let event = EventForm(eventName: eventName, isOffline: isOffline, date: date, location: location, madeBy: madeBy, shortDescription: shortDescription, longDescription: longDescription, maximumPlaces: maximumPlaces)
    
    DataManager.shared.createEvent(event: event, image: image) { result, error in
      if !result {
        self.alertMessage = error ?? "Impossible d'enregister l'évènement"
        self.showAlert.toggle()
      }
    }
  }
  
  func disableButton() -> Bool {
    if eventName.isEmpty,
       location.isEmpty,
       location.isEmpty,
       madeBy.isEmpty,
       shortDescription.isEmpty,
       longDescription.isEmpty {
      return false
    } else {
      return true
    }
  }
}

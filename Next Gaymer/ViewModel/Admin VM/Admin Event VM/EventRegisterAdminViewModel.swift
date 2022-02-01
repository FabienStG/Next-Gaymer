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
  @Published var description = ""
  @Published var maximumPlaces: CGFloat = 0
  
  @Published var alertMessage = ""
  @Published var showAlert = false
  @Published var showConfirmation = false
  
  @Published var changeBannerImage = false
  @Published var openCameraRoll = false
  
  @Published var requestStatus: RequestStatus = .initial
  
  func registrateEvent() {
    
    let event = EventForm(eventName: eventName, isOffline: isOffline, date: date, startHour: startHour, endHour: endHour, location: location, madeBy: madeBy, description: description, maximumPlaces: Int(maximumPlaces))
    
    DataManager.shared.createEvent(event: event, image: image) { result, error in
      if !result {
        self.alertMessage = error ?? "Impossible d'enregister l'évènement"
        self.showAlert.toggle()
        self.requestStatus = .fail
      } else if result {
        self.requestStatus = .success
      }
    }
  }
}

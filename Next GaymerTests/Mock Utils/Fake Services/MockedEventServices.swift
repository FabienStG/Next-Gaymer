//
//  MockedEventServices.swift
//  Next GaymerTests
//
//  Created by Fabien Saint Germain on 14/02/2022.
//

import SwiftUI
@testable import Next_Gaymer

class MockedEventServices: EventServices {
  
  func saveEventImage(image: UIImage, eventId: String, completionHandler: @escaping (Bool, String) -> Void) {
    let imageURL = FakeData.image
    return completionHandler(true, imageURL)
  }
  
  func createEvent(with event: EventCreated, completionHandler: @escaping (Bool, String?) -> Void) {
    return completionHandler(true, nil)
  }
  
  func fetchAllEvents(successHandler: @escaping ([EventCreated]) -> Void, errorHandler: @escaping (String) -> Void) {
    var eventArray = [EventCreated]()
    eventArray.append(FakeData.eventWithRegisters)
    eventArray.append(FakeData.eventWithNoRegisters)
    return successHandler(eventArray)
  }
  
  func checkIfEventAvailable(currentUser: UserRegistered, event: EventCreated, completionHandler: @escaping (Bool, String?) -> Void) {
    if event.registrant.contains(where: { $0.id == currentUser.id }) {
      return completionHandler(false, NSLocalizedString("alreadyRegistrateEvent", comment: ""))
    }
    if event.maximumPlaces != 0 && event.maximumPlaces <= (event.registrant.count + 1) {
      return completionHandler(false, NSLocalizedString("eventFull", comment: ""))
    }
    return completionHandler(true, nil)
  }
  
  func registrateUserForEvent(currentUser: UserRegistered, event: EventCreated, completionHandler: @escaping (Bool, String) -> Void) {
    return completionHandler(true, NSLocalizedString("registrateComplete", comment: ""))
  }
  
  func deleteUserFromEvent(currentUser: UserRegistered, event: EventCreated, completionHandler: @escaping (Bool, String) -> Void) {
    return completionHandler(true, NSLocalizedString("registrationCanceled", comment: ""))
  }
  
  func fetchMyEvent(completionHandler: @escaping ([EventCreated], String?) -> Void) {
    var eventResult = [EventCreated]()
    eventResult.append(FakeData.eventWithRegisters)
    return completionHandler(eventResult, nil)
  }
  
  func addEventToUSer(event: EventCreated) {
    return
  }
  
  func removeEventToUser(event: EventCreated) {
    return
  }
}

class MockedEventServicesFailed: EventServices {
  func saveEventImage(image: UIImage, eventId: String, completionHandler: @escaping (Bool, String) -> Void) {
    return completionHandler(false, "error")
  }
  
  func createEvent(with event: EventCreated, completionHandler: @escaping (Bool, String?) -> Void) {
    return completionHandler(false, "error")
  }
  
  func fetchAllEvents(successHandler: @escaping ([EventCreated]) -> Void, errorHandler: @escaping (String) -> Void) {
    return errorHandler("error")
  }
  
  func checkIfEventAvailable(currentUser: UserRegistered, event: EventCreated, completionHandler: @escaping (Bool, String?) -> Void) {
    return completionHandler(false, NSLocalizedString("noEvent", comment: ""))
  }
  
  func registrateUserForEvent(currentUser: UserRegistered, event: EventCreated, completionHandler: @escaping (Bool, String) -> Void) {
    return completionHandler(true, NSLocalizedString("registrateComplete", comment: ""))
  }
  
  func deleteUserFromEvent(currentUser: UserRegistered, event: EventCreated, completionHandler: @escaping (Bool, String) -> Void) {
    return completionHandler(false, "error")
  }
  
  func fetchMyEvent(completionHandler: @escaping ([EventCreated], String?) -> Void) {
    return completionHandler([], "error")
  }
  
  func addEventToUSer(event: EventCreated) {
    return
  }
  
  func removeEventToUser(event: EventCreated) {
    return
  }
}

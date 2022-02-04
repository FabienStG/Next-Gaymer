//
//  FirebaseEventServices.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 27/01/2022.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI
//
// MARK: - Firebase Event Services
//

/// This class manage all the calls used for the events fonction
class FirebaseEventServices {
  //
  // MARK: - Private Constant
  //
  private let auth = Auth.auth()
  private let db = Firestore.firestore()
  private let storage = Storage.storage()
  
  //
  // MARK: - Internal Methods
  //
  func saveEventImage(image: UIImage, eventId: String, completionHandler: @escaping(Bool, String) -> Void) {
    
    guard auth.currentUser?.uid != nil else { return }
    
    let ref = storage.reference(withPath: eventId)
    
    guard let imageData = image.jpegData(compressionQuality: 0.5) else {
      return completionHandler(false, NSLocalizedString("failImageCompression", comment: ""))
    }
    ref.putData(imageData, metadata: nil) { metadata, error in
      if let error = error {
        return completionHandler(false, error.localizedDescription)
      }
      ref.downloadURL { url, error in
          if let error = error {
            return completionHandler(false, error.localizedDescription)
        }
      guard let url = url else { return }
        return completionHandler(true, url.absoluteString)
      }
    }
  }
  
  func createEvent(with event: EventForm, imageUrl: String, completionHandler: @escaping(Bool, String?) -> Void) {
    
    let eventCreated = EventCreated(id: event.id.uuidString, imageUrl: imageUrl, eventName: event.eventName,
                                    isOffline: event.isOffline, date: event.date, location: event.location,
                                    town: event.town, madeBy: event.madeBy, description: event.description,
                                    maximumPlaces: event.maximumPlaces, takenPlaces: 0, registrant: [UserDetails]())

    try? db.collection(EventConstant.events).document(eventCreated.id).setData(from: eventCreated) { error in
      if let error = error {
        return completionHandler(false, error.localizedDescription)
      } else {
        return completionHandler(true, nil)
      }
    }
  }
  
  func fetchAllEvents(successHandler: @escaping([EventCreated]) -> Void, errorHandler: @escaping(String) -> Void) {
    
    var eventList = [EventCreated]()
    db.collection(EventConstant.events).getDocuments { documentSnapshot, error in
      if let error = error {
        return errorHandler(error.localizedDescription)
      }
      documentSnapshot?.documents.forEach({ document in
        guard let event = try? document.data(as: EventCreated.self) else {
          return errorHandler(NSLocalizedString("failFetchEventList", comment: ""))
        }
        eventList.append(event)
      })
      return successHandler(eventList)
    }
  }
  
  func checkIfEventAvailable(currentUser: UserRegistered, event: EventCreated, completionHandler: @escaping(Bool, String?) ->Void) {

    db.collection(EventConstant.events).document(event.id).getDocument { documentSnapshot, error in
      let actualEvent = try? documentSnapshot?.data(as: EventCreated.self)
      
      guard let actualEvent = actualEvent  else {
        return completionHandler(false, NSLocalizedString("noEvent", comment: ""))
      }
      if actualEvent.registrant.contains(where: { $0.id == currentUser.id }) {
        return completionHandler(false, NSLocalizedString("alreadyRegistrateEvent", comment: ""))
      }
      
      if actualEvent.maximumPlaces != 0 && actualEvent.maximumPlaces <= (actualEvent.registrant.count - 1) {
        return completionHandler(false, NSLocalizedString("eventFull", comment: ""))
      }
      return completionHandler(true, nil)
    }
  }
  
  func registrateUserForEvent(currentUser: UserRegistered, event: EventCreated, completionHandler: @escaping(Bool, String) -> Void) {
    
    db.collection(EventConstant.events).document(event.id).updateData([
      "registrant": FieldValue.arrayUnion(self.convertUserToData(currentUser: currentUser)),
      "takenPlaces": FieldValue.increment(Int64(1))
    ]) { error in
      if let error = error {
        return completionHandler(false, error.localizedDescription)
      }
      return completionHandler(true, NSLocalizedString("registrateComplete", comment: ""))
    }
  }
  
  func deleteUserFromEvent(currentUser: UserRegistered, event: EventCreated, completionHandler: @escaping(Bool, String) -> Void) {
    db.collection(EventConstant.events).document(event.id).updateData([
      "registrant": FieldValue.arrayRemove(self.convertUserToData(currentUser: currentUser)),
      "takenPlace": FieldValue.increment(Int64(-1))
    ]) { error in
      if let error = error {
        return completionHandler(false, error.localizedDescription)
      }
      return completionHandler(true, NSLocalizedString("cancelRegistration", comment: ""))
    }
  }
  
  func fetchMyEvent(currentUser: UserRegistered, completionHandler: @escaping([EventCreated], String?) -> Void) {
    
    let myEventId = currentUser.myEvent
    var returnedEventList = [EventCreated]()
    myEventId.forEach { eventId in
      
      db.collection(EventConstant.events).document(eventId).getDocument { document, error in
        let event = try? document?.data(as: EventCreated.self)
        if let event = event {
          returnedEventList.append(event)
        }
        return completionHandler(returnedEventList, error?.localizedDescription)
      }
    }
    return completionHandler(returnedEventList, nil)
}
  
  private func convertUserToData(currentUser: UserRegistered) -> [Any] {

    let packedUser = UserDetails(id: currentUser.id, pseudo: currentUser.pseudo, name: currentUser.name,
                                 surname: currentUser.surname, email: currentUser.email, city: currentUser.city,
                                 profileImageUrl: currentUser.profileImageUrl, isAdmin: currentUser.isAdmin)
    
    var user = [Any]()
    let jsonData = (try? JSONEncoder().encode(packedUser))!
    let jsonObject = (try? JSONSerialization.jsonObject(with: jsonData, options: []))!
    user.append(jsonObject)
    
    return user
  }
}


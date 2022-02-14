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
class FirebaseEventServices: EventServices {
  //
  // MARK: - Private Constant
  //
  private let auth = Auth.auth()
  private let db = Firestore.firestore()
  private let storage = Storage.storage()
  
  //
  // MARK: - Internal Methods
  //
  /// Save the selected UIImage by the user, save it into Storage and return the URL
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
  
  /// Take all the informations from the event form registered by the user and the url from saved image, and save it in Firestore as new object
  func createEvent(with event: EventCreated, completionHandler: @escaping(Bool, String?) -> Void) {
    
    try? db.collection(EventConstant.events).document(event.id).setData(from: event) { error in
      if let error = error {
        return completionHandler(false, error.localizedDescription)
      } else {
        return completionHandler(true, nil)
      }
    }
  }
  
  /// Fetch all the created events from Firebase and return them into an array
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
  
  /// When a user whant to register to an event, it check if is not already registered, and if the event have still place
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
  
  /// Add the user info as UserDetails in the event array, and increment the taken places by 1
  func registrateUserForEvent(currentUser: UserRegistered, event: EventCreated, completionHandler: @escaping(Bool, String) -> Void) {
    
    db.collection(EventConstant.events).document(event.id).updateData([
      EventConstant.registrant: FieldValue.arrayUnion(self.convertUserToData(currentUser: currentUser)),
      EventConstant.takenPlaces: FieldValue.increment(Int64(1))
    ]) { error in
      if let error = error {
        return completionHandler(false, error.localizedDescription)
      }
      return completionHandler(true, NSLocalizedString("registrateComplete", comment: ""))
    }
  }
  
  /// With the .arrayRemove, Firebase can check if the user entry is on is registrant array, and remove it.
  func deleteUserFromEvent(currentUser: UserRegistered, event: EventCreated, completionHandler: @escaping(Bool, String) -> Void) {
    
    db.collection(EventConstant.events).document(event.id).updateData([
      EventConstant.registrant: FieldValue.arrayRemove(self.convertUserToData(currentUser: currentUser)),
      EventConstant.takenPlaces: FieldValue.increment(Int64(-1))
    ]) { error in
      if let error = error {
        return completionHandler(false, error.localizedDescription)
      }
      return completionHandler(true, NSLocalizedString("registrationCanceled", comment: ""))
    }
  }
  
  /// Take the registered events array from the user profile, and loop every Id to return an array of events
  func fetchMyEvent(completionHandler: @escaping([EventCreated], String?) -> Void) {
    let myGroup = DispatchGroup()
    var eventResult = [EventCreated]()
    guard let userId = auth.currentUser?.uid else { return }
    
    db.collection(UserConstant.users).document(userId).getDocument { user, error in
      let currentUser = try? user?.data(as: UserRegistered.self)
      if let currentUser = currentUser {
        currentUser.myEvent.forEach { eventId in
          myGroup.enter()
          self.fetchEvent(eventId: eventId) { eventFetched in
            eventResult.append(eventFetched)
            myGroup.leave()
          }
        }
        myGroup.notify(queue: .main) {
          return completionHandler(eventResult, nil)
        }
      }
      return completionHandler([], error?.localizedDescription)
    }
  }
  
  /// Add the event Id to the event array, and create a document in seperate collection to save the reminder status
  func addEventToUSer(event: EventCreated) {
    
    guard let userId = auth.currentUser?.uid else { return }
    db.collection(EventConstant.eventReminder).document(userId).collection(userId).document(event.id).setData([EventConstant.reminderIsActive: false])
    db.collection(UserConstant.users).document(userId).updateData([
      UserConstant.myEvent: FieldValue.arrayUnion([event.id])])
  }
   
  /// Remove the event id from the user event array and delete the seperate collection who saved the reminder status
  func removeEventToUser(event: EventCreated) {
    
    guard let userId = auth.currentUser?.uid else { return }
    db.collection(EventConstant.eventReminder).document(userId).collection(userId).document(event.id).delete()
    db.collection(UserConstant.users).document(userId).updateData([
      UserConstant.myEvent: FieldValue.arrayRemove([event.id])])
  }

  //
  // MARK: - Private Method
  //
  /// Private method used to convert a user registered into a user details and save it as data for nested object firebase purposes
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
  
  /// Private method used by the loop to fetch every event with is specitif Id
  private func fetchEvent(eventId: String, completionHandler: @escaping(EventCreated) -> Void) {
    
    db.collection(EventConstant.events).document(eventId).getDocument { document, error in
      if let document = document {
        guard let event = try? document.data(as: EventCreated.self) else { return }
        return completionHandler(event)
        
      }
    }
  }
}


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

class FirebaseEventServices {
  
  private let auth = Auth.auth()
  private let db = Firestore.firestore()
  private let storage = Storage.storage()
  
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
    
    let eventCreated = EventCreated(id: event.id.uuidString, imageUrl: imageUrl, eventName: event.eventName, isOffline: event.isOffline, date: event.date, startHour: event.startHour, endHour: event.endHour, location: event.location, madeBy: event.madeBy, description: event.description, maximumPlaces: event.maximumPlaces, takenPlaces: 0, registrant: [String]())

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
}

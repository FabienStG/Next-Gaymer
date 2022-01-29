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
      return completionHandler(false, "Impossible de compresser l'image")
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
  
  func registrateEvent(with event: EventForm, imageUrl: String, completionHandler: @escaping(Bool, String?) -> Void) {
    
    let eventRegistered = EventRegistered(id: event.id.uuidString, imageUrl: imageUrl, eventName: event.eventName, isOffline: event.isOffline, date: event.date, location: event.location, madeBy: event.madeBy, shortDescription: event.shortDescription, longDescription: event.longDescription, maximumPlaces: event.maximumPlaces, takenPlaces: event.takenPlaces)

    try? db.collection(EventConstant.events).document(eventRegistered.id).setData(from: eventRegistered) { error in
      if let error = error {
        return completionHandler(false, error.localizedDescription)
      } else {
        return completionHandler(true, nil)
      }
    }
  }
}

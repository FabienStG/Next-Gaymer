//
//  EventServicesProtocol.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 14/02/2022.
//

import SwiftUI

protocol EventServices {
  
  /// Save the given image in storage
  func saveEventImage(image: UIImage, eventId: String, completionHandler: @escaping(Bool, String) -> Void)
  
  /// Take all the informations from the event form registered by the user and the url from saved image, and save it in Firestore as new object
  func createEvent(with event: EventCreated, completionHandler: @escaping(Bool, String?) -> Void)
  
  /// Fetch all the created events from Firebase and return them into an array
  func fetchAllEvents(successHandler: @escaping([EventCreated]) -> Void, errorHandler: @escaping(String) -> Void)
  
  /// When a user whant to register to an event, it check if is not already registered, and if the event have still place
  func checkIfEventAvailable(currentUser: UserRegistered, event: EventCreated, completionHandler: @escaping(Bool, String?) ->Void)
  
  /// Add the user info as UserDetails in the event array, and increment the taken places by 1
  func registrateUserForEvent(currentUser: UserRegistered, event: EventCreated, completionHandler: @escaping(Bool, String) -> Void)
  
  /// With the .arrayRemove, Firebase can check if the user entry is on is registrant array, and remove it.
  func deleteUserFromEvent(currentUser: UserRegistered, event: EventCreated, completionHandler: @escaping(Bool, String) -> Void)
  
  /// Take the registered events array from the user profile, and loop every Id to return an array of events
  func fetchMyEvent(completionHandler: @escaping([EventCreated], String?) -> Void)
  
  /// Add the event Id to the event array, and create a document in seperate collection to save the reminder status
  func addEventToUSer(event: EventCreated)
   
  /// Remove the event id from the user event array and delete the seperate collection who saved the reminder status
  func removeEventToUser(event: EventCreated)
}

//
//  EventServicesProtocol.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 14/02/2022.
//

import SwiftUI
//
// MARK: - Event Services Protocol
//

/// This protocol help for the firebase mocking tests
protocol EventServices {
  
  func saveEventImage(image: UIImage, eventId: String, completionHandler: @escaping(Bool, String) -> Void)
  
  func createEvent(with event: EventCreated, completionHandler: @escaping(Bool, String?) -> Void)
  
  func fetchAllEvents(successHandler: @escaping([EventCreated]) -> Void, errorHandler: @escaping(String) -> Void)
  
  func checkIfEventAvailable(currentUser: UserRegistered, event: EventCreated, completionHandler: @escaping(Bool, String?) ->Void)
  
  func registrateUserForEvent(currentUser: UserRegistered, event: EventCreated, completionHandler: @escaping(Bool, String) -> Void)
  
  func deleteUserFromEvent(currentUser: UserRegistered, event: EventCreated, completionHandler: @escaping(Bool, String) -> Void)
  
  func fetchMyEvent(completionHandler: @escaping([EventCreated], String?) -> Void)
  
  func addEventToUSer(event: EventCreated)
   
  func removeEventToUser(event: EventCreated)
}

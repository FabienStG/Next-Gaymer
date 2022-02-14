//
//  AdminServicesProtocol.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 14/02/2022.
//

import Foundation

protocol AdminServices {
  /// Update the user info saved into firestore to change a parameter and turn into true, giving him the app admin credentials
  func setUserAdminCredentials(userId: String, completionHandler: @escaping(String) -> Void)
  
  /// Fetch all the users registered in the firestore and return as an array
  func fetchAllUsers(successHandler: @escaping ([UserRegistered]) -> Void, errorHandler: @escaping(String) -> Void)

  /// Check the registrants array in the event object saved in firestore and return it
  func fetchEventRegistrants(event: EventCreated, successHandler: @escaping([UserDetails]) -> Void, errorHandler: @escaping(String) -> Void)
}

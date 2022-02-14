//
//  UserServicesProtocol.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 14/02/2022.
//

import Foundation

protocol UserServices {
  ///This is one of the most important and used function, who return the current user profile use by the app
  func fetchCurrentUser(successHandler: @escaping(UserRegistered) -> Void, errorHandler: @escaping(String) -> Void)
  
  /// This function fetch the users and return the admin
  func fetchAllAdmin(successHandler: @escaping ([UserRegistered]) -> Void, errorHandler: @escaping(String) -> Void)
  
  /// TO IMPLEMENT
  /// This function delete all the current user info stored in the firestore and the storage.
  func deleteCurrentUser(completionHandler: @escaping(Bool, String?) -> Void)
  
  /// TO IMPLEMENT
  /// This function update the user info stored in firebase with the user modifications
  func updateUserInfo(userInfo: [String: Any], completionHandler: @escaping(Bool, String) -> Void)
}

//
//  RegistrationServicesProtocol.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 14/02/2022.
//

import SwiftUI

protocol RegistrationServices {
  ///This function create the user in the authentification app of firestore, with the email and the password provided
  func createUser(userEmail: String, userPassword: String, completionHandler: @escaping(Bool, String?) -> Void)
  
  /// With the choosen UIimage for the user profile, it saved it in the storage and return the url
  func saveProfileImage(image: UIImage, completionHandler: @escaping(Bool, String) -> Void)
  
  /// With the form provide by the user and the image, this function create the final userRegistered object saved into firestore
  func registrateUser(with user: UserForm, image: UIImage, completionHandler: @escaping(Bool, String?) -> Void)
  
  /// Create a user with the info provide by Google Sign in and complete by the user
  func registrateGoogleUser(with user: UserRegistered, completionHandler: @escaping(Bool, String?) -> Void)
  
  /// This function provide by the Google documentation manage the account with his own credentials
  func googleLoginUser(completionHandler: @escaping(Bool, String?) -> Void)
  
  /// This function fetch the info saved into the currentUser in Auth
  func getGoogleUserInfo(completionHandler: @escaping([String: String]?) -> Void)
  
  ///This function log in the user
  func loginUser(userEmail: String, userPassword: String, completionHandler: @escaping(Bool, String?) -> Void)

  /// It log out the user and signOut for Google if he use it
  func logoutUser(completionHandler: @escaping(Bool, String?) -> Void)
  
  /// Send an email to a registrate user who forget his password
  func resetPassword(emailUser: String, completionHandler: @escaping(Bool, String?) -> Void)
}

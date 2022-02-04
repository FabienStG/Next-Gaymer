//
//  UserDetailForm.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 21/01/2022.
//

import Foundation
//
// MARK: - User Form
//

/// This struc used to save the users text field from view and parse to save them into Firebase throught User Registered
struct UserForm {
  
  let name: String
  let surname: String
  let pseudo: String
  let email: String
  let phoneNumber: String
  let discordPseudo: String
  let street: String
  let zipCode: String
  let city: String
  
}

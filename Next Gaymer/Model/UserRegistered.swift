//
//  UserRegistered.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 21/01/2022.
//

import Foundation
//
// MARK: - User Registered
//

/// The object used to save the user's data into Firebase
struct UserRegistered: Codable {
  
  let id: String
  let name: String
  let surname: String
  let pseudo: String
  let profileImageUrl: String
  let email: String
  let phoneNumber: String
  let discordPseudo: String
  let street: String
  let zipCode: String
  let city: String
  let isAdmin: Bool
  let myEvent: [String]
}

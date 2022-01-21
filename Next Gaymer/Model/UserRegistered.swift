//
//  UserRegistered.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 21/01/2022.
//

import Foundation

struct UserRegistered: Codable {
  
  var id: String
  var name: String
  var surname: String
  var pseudo: String
  var profileImageUrl: String
  var email: String
  var phoneNumber: String
  var discordPseudo: String
  var street: String
  var zipCode: String
  var city: String
  var isAdmin: Bool
    
}

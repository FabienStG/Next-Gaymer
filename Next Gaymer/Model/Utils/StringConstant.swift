//
//  StringConstant.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 21/01/2022.
//

import Foundation
//
// MARK: - String constants
//

/// Several struct who contains reusable strings for api calls to prevent any mistake

//
// MARK: - User Constant
//
struct UserConstant {
  
  static let userId = "userId"
  static let name = "name"
  static let surname = "surname"
  static let pseudo = "pseudo"
  static let profileImageUrl = "profileImageUrl"
  static let email = "email"
  static let phoneNumber = "phoneNumber"
  static let discordPseudo = "discordPseudo"
  static let street = "street"
  static let zipCode = "zipCode"
  static let city = "city"
  static let users = "users"
  static let myEvent = "myEvent"
}

//
// MARK: - Message Constant
//
struct MessageConstant {
  
  static let messages = "messages"
  static let timestamp = "timestamp"
  static let recentMessages = "recentMessages"
}

//
// MARK: - Event Constant
//
struct EventConstant {
  
  static let events = "events"
  static let takenPlaces = "takenPlaces"
  static let registrant = "registrant"
  
}

//
// MARK: - Debug Constant
//
struct DebugConstant {
  
  static let emulator = """
    ***************************
    Testing on Emulator
    ***************************
    """
  
  static let debug =  """
    ***************************
    Testing on Live Server
    *************************** 
   """
}

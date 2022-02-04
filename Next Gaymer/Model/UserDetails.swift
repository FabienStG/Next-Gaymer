//
//  UserLimitedDetails.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 22/01/2022.
//

import Foundation
//
// MARK: - UserDetails
//

/// This struct, from UserRegistered, provide a limited acces to user's data for privacy
struct UserDetails: Codable, Identifiable, Hashable {
  
  let id: String
  let pseudo: String
  let name: String
  let surname: String
  let email: String
  let city: String
  let profileImageUrl: String
  let isAdmin: Bool
}

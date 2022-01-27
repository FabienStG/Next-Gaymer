//
//  UserLimitedDetails.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 22/01/2022.
//

import Foundation

struct UserDetails: Codable, Identifiable {
  
  let id: String
  let pseudo: String
  let name: String
  let surname: String
  let email: String
  let city: String
  let profileImageUrl: String
  let isAdmin: Bool
  
}

//
//  HelpCenter.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 22/02/2022.
//

import Foundation
//
// MARK: - Help Center
//

/// This struc is made from CenterRegistered and use for display
struct HelpCenter: Identifiable {
  
  let id: String
  let name: String
  let phoneNumber: String
  let phoneNumberURL: URL
  let url: URL
  var description: String
}

//
//  Event.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 26/01/2022.
//

import Foundation
//
// MARK: - Event Form
//

/// Struct used to pass the fields into an object convertible for Firebase
struct EventForm {
  
  let id = UUID()
  let eventName: String
  let isOffline: Bool
  let date: Date
  let location: String
  let town: String
  let madeBy: String
  let description: String
  let maximumPlaces: Int
}

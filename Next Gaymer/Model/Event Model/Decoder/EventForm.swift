//
//  Event.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 26/01/2022.
//

import Foundation

struct EventForm {
  
  let id = UUID()
  let eventName: String
  let isOffline: Bool
  let date: Date
  let location: String
  let madeBy: String
  let shortDescription: String
  let longDescription: String
  let maximumPlaces: Int
  let takenPlaces: Int
  
}

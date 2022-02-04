//
//  EventRegistered.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 27/01/2022.
//

import Foundation
//
// MARK: - Event Created
//

/// Combine with the Event Form struct and other data, it's the final object stored in Firebase for Events
struct EventCreated: Codable, Identifiable {
  
  let id: String
  let imageUrl: String
  let eventName: String
  let isOffline: Bool
  let date: Date
  let location: String
  let town: String
  let madeBy: String
  let description: String
  let maximumPlaces: Int
  var takenPlaces: Int
  var registrant: [UserDetails]
  
  var dateString: String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter.string(from: date)
  }
}

//
//  EventRegistered.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 27/01/2022.
//

import Foundation

struct EventCreated: Codable, Identifiable {
  
  let id: String
  let imageUrl: String
  let eventName: String
  let isOffline: Bool
  let date: Date
  let startHour: Date
  let endHour: Date
  let location: String
  let town: String
  let madeBy: String
  let description: String
  let maximumPlaces: Int
  let takenPlaces: Int
  let registrant: [String]
  
  var dateString: String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter.string(from: date)
  }
  
  var startHourString: String {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter.string(from: startHour)
  }
  
  var endHourString: String {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter.string(from: endHour)
  }
}

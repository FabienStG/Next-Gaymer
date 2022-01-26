//
//  Event.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 26/01/2022.
//

import Foundation
import FirebaseFirestoreSwift

struct Event: Codable, Identifiable {
  
  @DocumentID var id: String?
  
  let eventName: String
  let imageUrl: String
  let isOffline: Bool
  let date: Date
  let location: String
  let madeBy: String
  let shortDescription: String
  let longDescription: String
  let maximumPlaces: Int
  let takenPlaces: Int
  
}

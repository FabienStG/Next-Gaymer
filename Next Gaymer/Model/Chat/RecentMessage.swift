//
//  RecentMessage.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 22/01/2022.
//

import Foundation
import FirebaseFirestoreSwift

struct RecentMessage: Codable, Identifiable {
  
  @DocumentID var id: String?
  
  let text: String
  let senderUserId: String
  let recipientUserId: String
  let timestamp: Date
  let profileImageUrl: String
  let pseudo: String
  let isAdmin: Bool
}

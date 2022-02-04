//
//  RecentMessage.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 22/01/2022.
//

import Foundation
import FirebaseFirestoreSwift
//
// MARK: - RecentMessage
//

/// It's the object who save the last chat message send for the Recent Message view, and save into Firebase
struct RecentMessage: Codable, Identifiable {
  
  @DocumentID var id: String?
  
  let text: String
  let senderUserId: String
  let recipientUserId: String
  let timestamp: Date
  let profileImageUrl: String
  let pseudo: String
  let isAdmin: Bool
  
  var timeAgo: String {
    let formatter = RelativeDateTimeFormatter()
    formatter.unitsStyle = .abbreviated
    return formatter.localizedString(for: timestamp, relativeTo: Date())
  }
}

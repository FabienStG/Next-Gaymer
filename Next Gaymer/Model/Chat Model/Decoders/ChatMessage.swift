//
//  ChatMessage.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 22/01/2022.
//

import Foundation
import FirebaseFirestoreSwift
//
// MARK: - Chat Message
//

/// It's the object message saved in Firebase and used for the chat function
struct ChatMessage: Codable, Identifiable {
  
  @DocumentID var id: String?
  
  let senderUserId: String
  let recipientUserId: String
  let text: String
  let timestamp: Date
}
